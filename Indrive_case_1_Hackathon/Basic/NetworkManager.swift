//
//  NetworkManager.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    private init() {}
    
    func request(_ target: TargetType, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        do {
            let urlRequest = try buildRequest(from: target)
            
            session.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(.moyaError(.underlying(error, nil))))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    let responseObject = Response(
                        statusCode: httpResponse.statusCode,
                        data: data,
                        request: urlRequest,
                        response: httpResponse
                    )
                    
                    guard 200...299 ~= httpResponse.statusCode else {
                        completion(.failure(.serverError("HTTP \(httpResponse.statusCode)")))
                        return
                    }
                    
                    completion(.success(responseObject))
                }
            }.resume()
            
        } catch {
            completion(.failure(.invalidURL))
        }
    }
    
    private func buildRequest(from target: TargetType) throws -> URLRequest {
        let url = target.baseURL.appendingPathComponent(target.path)
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        
        // Add headers
        target.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Handle task
        switch target.task {
        case .requestPlain:
            break
        case .requestJSONEncodable(let encodable):
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(encodable)
        case .requestData(let data):
            request.httpBody = data
        case .requestParameters(let parameters, let encoding):
            request = try encoding.encode(request, with: parameters)
        }
        
        return request
    }
    
    private func buildMultipartBody(multipartData: [MultipartFormData], boundary: String) -> Data {
        var body = Data()
        
        for data in multipartData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            
            if let fileName = data.fileName {
                body.append("Content-Disposition: form-data; name=\"\(data.name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            } else {
                body.append("Content-Disposition: form-data; name=\"\(data.name)\"\r\n".data(using: .utf8)!)
            }
            
            if let mimeType = data.mimeType {
                body.append("Content-Type: \(mimeType)\r\n".data(using: .utf8)!)
            }
            
            body.append("\r\n".data(using: .utf8)!)
            body.append(data.data)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}

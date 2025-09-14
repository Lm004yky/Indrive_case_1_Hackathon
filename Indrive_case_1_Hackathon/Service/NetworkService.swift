//
//  NetworkService.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getApplications(completion: @escaping (Result<ApplicationResponse, Error>) -> Void)
    func getApplication(id: Int, completion: @escaping (Result<Application, Error>) -> Void)
    func createApplication(request: CreateApplicationRequest, completion: @escaping (Result<Application, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://91a784fe7f0a.ngrok-free.app"
    private let session = URLSession.shared
    
    // MARK: - GET Applications
    func getApplications(completion: @escaping (Result<ApplicationResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/application/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        performRequest(request: request, responseType: ApplicationResponse.self, completion: completion)
    }
    
    // MARK: - GET Application by ID
    func getApplication(id: Int, completion: @escaping (Result<Application, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/application/\(id)/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        performRequest(request: request, responseType: Application.self, completion: completion)
    }
    
    // MARK: - POST Create Application
    func createApplication(request: CreateApplicationRequest, completion: @escaping (Result<Application, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/application/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(.failure(error))
            return
        }
        
        performRequest(request: urlRequest, responseType: Application.self, completion: completion)
    }
    
    // MARK: - Generic Request Performer
    private func performRequest<T: Codable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    completion(.failure(NetworkError.serverError(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

// MARK: - Network Errors
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data received"
        case .serverError(let code):
            return "Server error with code: \(code)"
        }
    }
}

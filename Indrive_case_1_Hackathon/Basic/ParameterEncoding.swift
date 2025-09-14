//
//  ParameterEncoding.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: [String: Any]?) throws -> URLRequest
}

public struct JSONEncoding: ParameterEncoding {
    public static var `default`: JSONEncoding { return JSONEncoding() }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: [String: Any]?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return request }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = data
            
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw error
        }
        
        return request
    }
}

public struct URLEncoding: ParameterEncoding {
    public static var `default`: URLEncoding { return URLEncoding() }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: [String: Any]?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        
        guard let parameters = parameters, !parameters.isEmpty else { return request }
        
        let query = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        
        if var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) {
            urlComponents.query = query
            request.url = urlComponents.url
        }
        
        return request
    }
}

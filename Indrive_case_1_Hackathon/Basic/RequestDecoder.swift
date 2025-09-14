//
//  RequestDecoder.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class RequestDecoder {
    static let shared = RequestDecoder()
    private init() {}
    
    func decodeResult<T: Codable>(_ result: Result<Response, NetworkError>, for type: T.Type) -> Result<T, NetworkError> {
        switch result {
        case .success(let response):
            do {
                let decoded = try JSONDecoder().decode(type, from: response.data)
                return .success(decoded)
            } catch {
                return .failure(.decodingError(error))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

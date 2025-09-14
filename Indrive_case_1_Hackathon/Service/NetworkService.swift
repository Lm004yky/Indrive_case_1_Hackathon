//
//  NetworkService.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getApplications(completion: @escaping (Result<ApplicationResponse, NetworkError>) -> Void)
    func getApplication(id: Int, completion: @escaping (Result<Application, NetworkError>) -> Void)
    func createApplication(request: CreateApplicationRequest, completion: @escaping (Result<Application, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let provider = NetworkManager.shared
    
    func getApplications(completion: @escaping (Result<ApplicationResponse, NetworkError>) -> Void) {
        provider.request(ApplicationEndpoints.getApplications) { result in
            let decoded = RequestDecoder.shared.decodeResult(result, for: ApplicationResponse.self)
            completion(decoded)
        }
    }
    
    func getApplication(id: Int, completion: @escaping (Result<Application, NetworkError>) -> Void) {
        provider.request(ApplicationEndpoints.getApplication(id: id)) { result in
            let decoded = RequestDecoder.shared.decodeResult(result, for: Application.self)
            completion(decoded)
        }
    }
    
    func createApplication(request: CreateApplicationRequest, completion: @escaping (Result<Application, NetworkError>) -> Void) {
        provider.request(ApplicationEndpoints.createApplication(request)) { result in
            let decoded = RequestDecoder.shared.decodeResult(result, for: Application.self)
            completion(decoded)
        }
    }
}

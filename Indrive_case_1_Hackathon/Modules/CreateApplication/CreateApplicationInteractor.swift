//
//  CreateApplicationInteractor.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class CreateApplicationInteractor: CreateApplicationInteractorProtocol {
    weak var presenter: CreateApplicationInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func createApplication(request: CreateApplicationRequest) {
        networkService.createApplication(request: request) { [weak self] result in
            switch result {
            case .success:
                self?.presenter?.applicationCreated()
            case .failure(let error):
                self?.presenter?.applicationCreationFailed(with: error)
            }
        }
    }
}

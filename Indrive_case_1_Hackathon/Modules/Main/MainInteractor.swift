//
//  MainInteractor.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchApplications() {
        networkService.getApplications { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.applicationsFetched(response.results)
            case .failure(let error):
                self?.presenter?.applicationsFetchFailed(with: error)
            }
        }
    }
}

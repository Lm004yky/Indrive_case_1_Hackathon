//
//  ApplicationDetailInteractor.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class ApplicationDetailInteractor: ApplicationDetailInteractorProtocol {
    weak var presenter: ApplicationDetailInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func checkApplicationWithAI(_ application: Application) {
        // TODO: Implement AI check when endpoint is ready
        // For now, simulate AI check
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            // Simulate AI result (random for demo)
            let isClean = Bool.random()
            let message = isClean ? "Автомобиль чистый, проблем не обнаружено" : "Обнаружены повреждения: царапины на двери"
            self?.presenter?.aiCheckCompleted(result: isClean, message: message)
        }
    }
    
    func updateApplicationStatus(id: Int, status: String) {
        // TODO: Implement status update API call
        // For now, simulate success
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.presenter?.applicationStatusUpdated()
        }
    }
}

//
//  ApplicationDetailPresenter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation
import UIKit

class ApplicationDetailPresenter: ApplicationDetailPresenterProtocol {
    weak var view: ApplicationDetailViewProtocol?
    var interactor: ApplicationDetailInteractorProtocol?
    var router: ApplicationDetailRouterProtocol?
    
    private var application: Application?
    
    func setApplication(_ application: Application) {
        self.application = application
    }
    
    func viewDidLoad() {
        if let application = application {
            view?.showApplication(application)
        }
    }
    
    func approveApplication() {
        guard let application = application else { return }
        view?.showLoading()
        interactor?.updateApplicationStatus(id: application.id, status: "approved")
    }
    
    func rejectApplication() {
        guard let application = application else { return }
        view?.showLoading()
        interactor?.updateApplicationStatus(id: application.id, status: "rejected")
    }
    
    func checkWithAI() {
        guard let application = application else { return }
        view?.showLoading()
        interactor?.checkApplicationWithAI(application)
    }
}

// MARK: - ApplicationDetailInteractorOutputProtocol
extension ApplicationDetailPresenter: ApplicationDetailInteractorOutputProtocol {
    func aiCheckCompleted(result: Bool, message: String) {
        view?.hideLoading()
        view?.showAICheckResult(success: result, message: message)
    }
    
    func applicationStatusUpdated() {
        view?.hideLoading()
        guard let view = view as? UIViewController else { return }
        router?.dismissDetail(from: view)
    }
    
    func operationFailed(with error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}

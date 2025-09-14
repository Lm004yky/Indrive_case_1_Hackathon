//
//  MainPresenter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    
    private var applications: [Application] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchApplications()
    }
    
    func refreshApplications() {
        interactor?.fetchApplications()
    }
    
    func didSelectApplication(at index: Int) {
        guard index < applications.count,
              let view = view as? UIViewController else { return }
        let application = applications[index]
        router?.navigateToApplicationDetail(application: application, from: view)
    }
    
    func navigateToCreateApplication() {
        guard let view = view as? UIViewController else { return }
        router?.navigateToCreateApplication(from: view)
    }
}

// MARK: - MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func applicationsFetched(_ applications: [Application]) {
        self.applications = applications
        view?.hideLoading()
        view?.showApplications(applications)
    }
    
    func applicationsFetchFailed(with error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}

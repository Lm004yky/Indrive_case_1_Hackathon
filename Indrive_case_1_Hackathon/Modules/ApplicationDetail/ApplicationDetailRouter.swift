//
//  ApplicationDetailRouter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

// MARK: - Application Detail Router
class ApplicationDetailRouter: ApplicationDetailRouterProtocol {
    static func createModule(application: Application) -> UIViewController {
        let view = ApplicationDetailViewController()
        let presenter = ApplicationDetailPresenter()
        let interactor = ApplicationDetailInteractor()
        let router = ApplicationDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.setApplication(application)
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func dismissDetail(from view: UIViewController) {
        view.dismiss(animated: true)
    }
}

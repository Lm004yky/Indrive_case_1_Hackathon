//
//  CreateApplicationRouter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

// MARK: - Create Application Router
class CreateApplicationRouter: CreateApplicationRouterProtocol {
    static func createModule() -> UIViewController {
        let view = CreateApplicationViewController()
        let presenter = CreateApplicationPresenter()
        let interactor = CreateApplicationInteractor()
        let router = CreateApplicationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func dismissCreateApplication(from view: UIViewController) {
        view.dismiss(animated: true)
    }
}

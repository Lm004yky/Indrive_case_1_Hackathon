//
//  MainRouter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

class MainRouter: MainRouterProtocol {
    static func createModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func navigateToApplicationDetail(application: Application, from view: UIViewController) {
        let detailViewController = ApplicationDetailRouter.createModule(application: application)
        view.present(detailViewController, animated: true)
    }
    
    func navigateToCreateApplication(from view: UIViewController) {
        let createApplicationViewController = CreateApplicationRouter.createModule()
        view.present(createApplicationViewController, animated: true)
    }
}

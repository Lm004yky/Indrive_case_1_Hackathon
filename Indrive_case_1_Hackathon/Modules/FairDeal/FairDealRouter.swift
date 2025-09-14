//
//  FairDealRouter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

class FairDealRouter: FairDealRouterProtocol {
    static func createModule() -> UIViewController {
        let view = FairDealViewController()
        let presenter = FairDealPresenter()
        let interactor = FairDealInteractor()
        let router = FairDealRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToMain(from view: UIViewController) {
        let mainViewController = MainRouter.createModule()
        
        // Replace root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
        }
    }
}

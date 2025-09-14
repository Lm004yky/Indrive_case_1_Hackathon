//
//  SplashRouter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    static func createModule() -> UIViewController {
        let view = SplashViewController()
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToFairDeal(from view: UIViewController) {
        let fairDealViewController = FairDealRouter.createModule()
        
        // Replace root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = fairDealViewController
            window.makeKeyAndVisible()
        }
    }
}

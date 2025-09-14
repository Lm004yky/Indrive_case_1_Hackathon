//
//  SplashProtocols.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
    func animateLogoFadeOut(completion: @escaping () -> Void)
}

protocol SplashPresenterProtocol: AnyObject {
    var view: SplashViewProtocol? { get set }
    var interactor: SplashInteractorProtocol? { get set }
    var router: SplashRouterProtocol? { get set }
    
    func viewDidLoad()
    func logoAnimationCompleted()
}

protocol SplashInteractorProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
    func startTimer()
}

protocol SplashRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToFairDeal(from view: UIViewController)
}

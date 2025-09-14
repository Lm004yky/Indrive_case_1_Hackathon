//
//  SplashPresenter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//


import Foundation
import UIKit

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    var router: SplashRouterProtocol?
    
    func viewDidLoad() {
        interactor?.startTimer()
    }
    
    func logoAnimationCompleted() {
        guard let view = view as? UIViewController else { return }
        router?.navigateToFairDeal(from: view)
    }
}

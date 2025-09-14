//
//  SplashInteractor.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation
import UIKit

class SplashInteractor: SplashInteractorProtocol {
    weak var presenter: SplashPresenterProtocol?
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.presenter?.view?.animateLogoFadeOut { [weak self] in
                self?.presenter?.logoAnimationCompleted()
            }
        }
    }
}

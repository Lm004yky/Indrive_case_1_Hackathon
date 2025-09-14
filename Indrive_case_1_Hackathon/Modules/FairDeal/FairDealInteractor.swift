//
//  FairDealInteractor.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation
import UIKit

class FairDealInteractor: FairDealInteractorProtocol {
    weak var presenter: FairDealPresenterProtocol?
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let presenter = self?.presenter,
                  let view = presenter.view as? UIViewController else { return }
            presenter.router?.navigateToMain(from: view)
        }
    }
}

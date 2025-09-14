//
//  FairDealPresenter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

class FairDealPresenter: FairDealPresenterProtocol {
    weak var view: FairDealViewProtocol?
    var interactor: FairDealInteractorProtocol?
    var router: FairDealRouterProtocol?
    
    func viewDidLoad() {
        interactor?.startTimer()
    }
}

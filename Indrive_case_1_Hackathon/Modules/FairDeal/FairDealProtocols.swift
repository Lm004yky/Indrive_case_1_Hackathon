//
//  FairDealProtocols.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

protocol FairDealViewProtocol: AnyObject {
    var presenter: FairDealPresenterProtocol? { get set }
}

protocol FairDealPresenterProtocol: AnyObject {
    var view: FairDealViewProtocol? { get set }
    var interactor: FairDealInteractorProtocol? { get set }
    var router: FairDealRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol FairDealInteractorProtocol: AnyObject {
    var presenter: FairDealPresenterProtocol? { get set }
    func startTimer()
}

protocol FairDealRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToMain(from view: UIViewController)
}

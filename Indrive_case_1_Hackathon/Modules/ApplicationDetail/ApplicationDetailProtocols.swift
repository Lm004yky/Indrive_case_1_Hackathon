//
//  ApplicationDetailProtocols.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

// MARK: - Application Detail Protocols
protocol ApplicationDetailViewProtocol: AnyObject {
    var presenter: ApplicationDetailPresenterProtocol? { get set }
    func showApplication(_ application: Application)
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showAICheckResult(success: Bool, message: String)
}

protocol ApplicationDetailPresenterProtocol: AnyObject {
    var view: ApplicationDetailViewProtocol? { get set }
    var interactor: ApplicationDetailInteractorProtocol? { get set }
    var router: ApplicationDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func approveApplication()
    func rejectApplication()
    func checkWithAI()
    func setApplication(_ application: Application)
}

protocol ApplicationDetailInteractorProtocol: AnyObject {
    var presenter: ApplicationDetailInteractorOutputProtocol? { get set }
    func checkApplicationWithAI(_ application: Application)
    func updateApplicationStatus(id: Int, status: String)
}

protocol ApplicationDetailInteractorOutputProtocol: AnyObject {
    func aiCheckCompleted(result: Bool, message: String)
    func applicationStatusUpdated()
    func operationFailed(with error: Error)
}

protocol ApplicationDetailRouterProtocol: AnyObject {
    static func createModule(application: Application) -> UIViewController
    func dismissDetail(from view: UIViewController)
}

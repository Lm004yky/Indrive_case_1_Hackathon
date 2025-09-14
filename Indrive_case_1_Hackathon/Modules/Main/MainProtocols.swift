//
//  MainProtocols.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func showApplications(_ applications: [Application])
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func viewDidLoad()
    func refreshApplications()
    func didSelectApplication(at index: Int)
    func navigateToCreateApplication()
}

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
    func fetchApplications()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func applicationsFetched(_ applications: [Application])
    func applicationsFetchFailed(with error: Error)
}

protocol MainRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToApplicationDetail(application: Application, from view: UIViewController)
    func navigateToCreateApplication(from view: UIViewController)
}

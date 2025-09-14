//
//  CreateApplicationProtocols.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

// MARK: - Create Application Protocols
protocol CreateApplicationViewProtocol: AnyObject {
    var presenter: CreateApplicationPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess()
    func updatePhotoCount(_ count: Int)
}

protocol CreateApplicationPresenterProtocol: AnyObject {
    var view: CreateApplicationViewProtocol? { get set }
    var interactor: CreateApplicationInteractorProtocol? { get set }
    var router: CreateApplicationRouterProtocol? { get set }
    
    func viewDidLoad()
    func addPhoto(_ image: UIImage)
    func removePhoto(at index: Int)
    func addLicensePhoto(_ image: UIImage)
    func removeLicensePhoto()
    func submitApplication(iin: String, name: String, surname: String)
}

protocol CreateApplicationInteractorProtocol: AnyObject {
    var presenter: CreateApplicationInteractorOutputProtocol? { get set }
    func createApplication(request: CreateApplicationRequest)
}

protocol CreateApplicationInteractorOutputProtocol: AnyObject {
    func applicationCreated()
    func applicationCreationFailed(with error: Error)
}

protocol CreateApplicationRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func dismissCreateApplication(from view: UIViewController)
}

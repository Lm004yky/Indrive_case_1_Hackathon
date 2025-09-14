//
//  CreateApplicationPresenter.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

class CreateApplicationPresenter: CreateApplicationPresenterProtocol {
    weak var view: CreateApplicationViewProtocol?
    var interactor: CreateApplicationInteractorProtocol?
    var router: CreateApplicationRouterProtocol?
    
    private var capturedPhotos: [UIImage] = []
    private var licensePhoto: UIImage?
    
    func viewDidLoad() {
        view?.updatePhotoCount(capturedPhotos.count)
    }
    
    func addPhoto(_ image: UIImage) {
        capturedPhotos.append(image)
        view?.updatePhotoCount(capturedPhotos.count)
    }
    
    func removePhoto(at index: Int) {
        guard index < capturedPhotos.count else { return }
        capturedPhotos.remove(at: index)
        view?.updatePhotoCount(capturedPhotos.count)
    }
    
    func addLicensePhoto(_ image: UIImage) {
        licensePhoto = image
    }
    
    func removeLicensePhoto() {
        licensePhoto = nil
    }
    
    func submitApplication(iin: String, name: String, surname: String) {
        guard !iin.isEmpty, !name.isEmpty, !surname.isEmpty else {
            view?.showError("Пожалуйста, заполните все поля")
            return
        }
        
        guard iin.count == 12 else {
            view?.showError("ИИН должен содержать 12 цифр")
            return
        }
        
        guard let licenseImage = licensePhoto else {
            view?.showError("Необходимо добавить фото водительского удостоверения")
            return
        }
        
        guard capturedPhotos.count >= 1 else {
            view?.showError("Необходимо добавить хотя бы одну фотографию автомобиля")
            return
        }
        
        let request = CreateApplicationRequest(
            iin: iin,
            name: name,
            surname: surname,
            carPhotos: capturedPhotos,
            licenseImage: licenseImage
        )
        
        view?.showLoading()
        interactor?.createApplication(request: request)
    }
}

// MARK: - CreateApplicationInteractorOutputProtocol
extension CreateApplicationPresenter: CreateApplicationInteractorOutputProtocol {
    func applicationCreated() {
        view?.hideLoading()
        view?.showSuccess()
    }
    
    func applicationCreationFailed(with error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}

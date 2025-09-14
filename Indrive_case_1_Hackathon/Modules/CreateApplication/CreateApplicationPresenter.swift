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
    
    func submitApplication(iin: String, name: String, surname: String) {
        guard !iin.isEmpty, !name.isEmpty, !surname.isEmpty else {
            view?.showError("Пожалуйста, заполните все поля")
            return
        }
        
        guard capturedPhotos.count >= 1 else {
            view?.showError("Необходимо добавить хотя бы одну фотографию автомобиля")
            return
        }
        
        // Convert images to CarPhoto objects (for MVP, we'll use placeholder URLs)
        let carPhotos = capturedPhotos.enumerated().map { index, _ in
            CarPhoto(id: nil, image: "placeholder_\(index).jpg", problems: nil, problemList: nil)
        }
        
        let license = License(id: nil, validatedIin: nil, validatedName: nil, validatedSurname: nil)
        
        let request = CreateApplicationRequest(
            iin: iin,
            name: name,
            surname: surname,
            carPhotos: carPhotos,
            license: license
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

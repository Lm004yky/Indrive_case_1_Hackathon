//
//  CreateApplicationViewController.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit
import SnapKit

class CreateApplicationViewController: UIViewController {
    var presenter: CreateApplicationPresenterProtocol?
    
    private var capturedImages: [UIImage] = []
    private var licenseImage: UIImage?
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: "grayBackground")
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayBackground")
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создание заявки"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let iinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ИИН"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "ИИН",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        return textField
    }()
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Фамилия",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    // MARK: - License Section
    private let licenseSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Водительское удостоверение"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let addLicenseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить фото удостоверения", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let licenseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        imageView.isHidden = true
        return imageView
    }()
    
    private let removeLicenseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("×", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.isHidden = true
        return button
    }()
    
    private let photoSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Фотографии автомобиля"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить фото", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.4, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото: 0"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить заявку", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.4, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private enum PhotoType {
        case license
        case car
    }
    
    private var currentPhotoType: PhotoType = .car
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCollectionView()
        setupActions()
        setupKeyboardHandling()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grayBackground")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeTapped)
        )
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [titleLabel, iinTextField, nameTextField, surnameTextField,
         licenseSectionLabel, addLicenseButton, licenseImageView, removeLicenseButton,
         photoSectionLabel, addPhotoButton, photosCollectionView,
         photoCountLabel, submitButton, loadingIndicator].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        iinTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(iinTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        licenseSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addLicenseButton.snp.makeConstraints { make in
            make.top.equalTo(licenseSectionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        licenseImageView.snp.makeConstraints { make in
            make.top.equalTo(addLicenseButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(120)
        }
        
        removeLicenseButton.snp.makeConstraints { make in
            make.top.equalTo(licenseImageView.snp.top).offset(-10)
            make.trailing.equalTo(licenseImageView.snp.trailing).offset(10)
            make.width.height.equalTo(30)
        }
        
        photoSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(licenseImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(photoSectionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(photoCountLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    private func setupActions() {
        addLicenseButton.addTarget(self, action: #selector(addLicenseTapped), for: .touchUpInside)
        removeLicenseButton.addTarget(self, action: #selector(removeLicenseTapped), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        // Настройка делегатов для текстовых полей
        iinTextField.delegate = self
        nameTextField.delegate = self
        surnameTextField.delegate = self
    }
    
    private func setupKeyboardHandling() {
        // Добавляем TapGestureRecognizer для закрытия клавиатуры при тапе по экрану
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Подписываемся на уведомления клавиатуры
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func addLicenseTapped() {
        currentPhotoType = .license
        presentPhotoSelection()
    }
    
    @objc private func removeLicenseTapped() {
        licenseImage = nil
        presenter?.removeLicensePhoto()
        updateLicenseUI()
    }
    
    @objc private func addPhotoTapped() {
        currentPhotoType = .car
        presentPhotoSelection()
    }
    
    private func presentPhotoSelection() {
        let alertController = UIAlertController(title: "Выберите источник", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .camera)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .photoLibrary)
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        // For iPad support
        if let popover = alertController.popoverPresentationController {
            let sourceView = currentPhotoType == .license ? addLicenseButton : addPhotoButton
            popover.sourceView = sourceView
            popover.sourceRect = sourceView.bounds
        }
        
        present(alertController, animated: true)
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    private func updateLicenseUI() {
        if licenseImage != nil {
            licenseImageView.image = licenseImage
            licenseImageView.isHidden = false
            removeLicenseButton.isHidden = false
            addLicenseButton.setTitle("Изменить фото удостоверения", for: .normal)
        } else {
            licenseImageView.isHidden = true
            removeLicenseButton.isHidden = true
            addLicenseButton.setTitle("Добавить фото удостоверения", for: .normal)
        }
    }
    
    @objc private func submitTapped() {
        presenter?.submitApplication(
            iin: iinTextField.text ?? "",
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? ""
        )
    }
}

// MARK: - UITextFieldDelegate
extension CreateApplicationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case iinTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ограничение для ИИН - только цифры и максимум 12 символов
        if textField == iinTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.count <= 12
        }
        
        return true
    }
}

// MARK: - CreateApplicationViewProtocol
extension CreateApplicationViewController: CreateApplicationViewProtocol {
    func showLoading() {
        loadingIndicator.startAnimating()
        submitButton.isEnabled = false
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        submitButton.isEnabled = true
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccess() {
        let alert = UIAlertController(title: "Успешно", message: "Заявка отправлена на модерацию", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    func updatePhotoCount(_ count: Int) {
        photoCountLabel.text = "Фото: \(count)"
        photosCollectionView.reloadData()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CreateApplicationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            handleSelectedImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            handleSelectedImage(originalImage)
        }
        picker.dismiss(animated: true)
    }
    
    private func handleSelectedImage(_ image: UIImage) {
        switch currentPhotoType {
        case .license:
            licenseImage = image
            presenter?.addLicensePhoto(image)
            updateLicenseUI()
        case .car:
            capturedImages.append(image)
            presenter?.addPhoto(image)
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension CreateApplicationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return capturedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: capturedImages[indexPath.item])
        cell.onDelete = { [weak self] in
            self?.capturedImages.remove(at: indexPath.item)
            self?.presenter?.removePhoto(at: indexPath.item)
        }
        return cell
    }
}

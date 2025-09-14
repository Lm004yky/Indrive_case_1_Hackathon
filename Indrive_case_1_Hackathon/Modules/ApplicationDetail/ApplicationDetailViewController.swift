//
//  ApplicationDetailViewController.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit

class ApplicationDetailViewController: UIViewController {
    var presenter: ApplicationDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grayBackground")
        title = "Детали заявки"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeTapped)
        )
        
        // TODO: Add full UI implementation
        let label = UILabel()
        label.text = "Экран детализации заявки\n(В разработке)"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

// MARK: - ApplicationDetailViewProtocol
extension ApplicationDetailViewController: ApplicationDetailViewProtocol {
    func showApplication(_ application: Application) {
        // TODO: Implement
    }
    
    func showLoading() {
        // TODO: Implement
    }
    
    func hideLoading() {
        // TODO: Implement
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showAICheckResult(success: Bool, message: String) {
        let title = success ? "Проверка пройдена" : "Обнаружены проблемы"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

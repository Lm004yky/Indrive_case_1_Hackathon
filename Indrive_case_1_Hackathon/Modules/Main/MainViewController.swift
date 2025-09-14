//
//  MainViewController.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit
import SnapKit

enum UserMode: Int, CaseIterable {
    case driver = 0
    case moderator = 1
    
    var title: String {
        switch self {
        case .driver:
            return "Драйвер"
        case .moderator:
            return "Модератор"
        }
    }
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    private var applications: [Application] = []
    private var currentMode: UserMode = .driver
    
    // MARK: - UI Components
    private let modeSelector: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: UserMode.allCases.map { $0.title })
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(white: 0.2, alpha: 1)
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.0, green: 0.8, blue: 0.4, alpha: 1)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        return segmentedControl
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "grayBackground")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let driverModeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayBackground")
        return view
    }()
    
    private let createApplicationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать заявку", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.4, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Сфотографируйте ваш автомобиль для создания заявки"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupModeSelector()
        setupActions()
        updateViewForCurrentMode()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grayBackground")
        title = "FairDeal"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(named: "grayBackground")
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(modeSelector)
        view.addSubview(tableView)
        view.addSubview(driverModeContainer)
        view.addSubview(loadingIndicator)
        
        driverModeContainer.addSubview(instructionLabel)
        driverModeContainer.addSubview(createApplicationButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        modeSelector.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(modeSelector.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        driverModeContainer.snp.makeConstraints { make in
            make.top.equalTo(modeSelector.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        createApplicationButton.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ApplicationTableViewCell.self, forCellReuseIdentifier: "ApplicationCell")
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupModeSelector() {
        modeSelector.addTarget(self, action: #selector(modeSelectorChanged), for: .valueChanged)
    }
    
    private func setupActions() {
        createApplicationButton.addTarget(self, action: #selector(createApplicationTapped), for: .touchUpInside)
    }
    
    @objc private func modeSelectorChanged() {
        currentMode = UserMode(rawValue: modeSelector.selectedSegmentIndex) ?? .driver
        updateViewForCurrentMode()
        
        if currentMode == .moderator {
            presenter?.viewDidLoad()
        }
    }
    
    private func updateViewForCurrentMode() {
        switch currentMode {
        case .driver:
            driverModeContainer.isHidden = false
            tableView.isHidden = true
            title = "FairDeal - Драйвер"
        case .moderator:
            driverModeContainer.isHidden = true
            tableView.isHidden = false
            title = "FairDeal - Модератор"
        }
    }
    
    @objc private func refreshData() {
        if currentMode == .moderator {
            presenter?.refreshApplications()
        } else {
            refreshControl.endRefreshing()
        }
    }
    
    @objc private func createApplicationTapped() {
        presenter?.navigateToCreateApplication()
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func showApplications(_ applications: [Application]) {
        self.applications = applications
        if currentMode == .moderator {
            tableView.reloadData()
        }
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMode == .moderator ? applications.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath) as? ApplicationTableViewCell else {
            return UITableViewCell()
        }
        
        if currentMode == .moderator && indexPath.row < applications.count {
            cell.configure(with: applications[indexPath.row])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if currentMode == .moderator {
            presenter?.didSelectApplication(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

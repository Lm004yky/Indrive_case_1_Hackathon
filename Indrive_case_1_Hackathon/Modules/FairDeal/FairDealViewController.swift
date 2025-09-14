//
//  FairDealViewController.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit
import SnapKit

class FairDealViewController: UIViewController {
    var presenter: FairDealPresenterProtocol?
    
    private let fairDealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "FairDeal")
        return imageView
    }()
    
    private let bottomLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "InDriveLogo")
        return imageView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .lightGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startLoading()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grayBackground")
        
        view.addSubview(fairDealImageView)
        view.addSubview(bottomLogoImageView)
        view.addSubview(loadingIndicator)
        
        fairDealImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(120)
        }
        
        bottomLogoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.top.equalTo(bottomLogoImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    private func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}

// MARK: - FairDealViewProtocol
extension FairDealViewController: FairDealViewProtocol {
    
}

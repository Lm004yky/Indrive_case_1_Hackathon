//
//  SplashViewController.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "InDriveLogo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "grayBackground")
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(120)
        }
    }
    
    func animateLogoFadeOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImageView.alpha = 0.0
        }) { _ in
            completion()
        }
    }
}

// MARK: - SplashViewProtocol
extension SplashViewController: SplashViewProtocol {
    
}

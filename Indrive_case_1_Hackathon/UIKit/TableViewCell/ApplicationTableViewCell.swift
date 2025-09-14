//
//  ApplicationTableViewCell.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//
import UIKit
import SnapKit

class ApplicationTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.15, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let iinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(iinLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(photoCountLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(statusLabel.snp.leading).offset(-8)
        }
        
        iinLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(statusLabel.snp.leading).offset(-8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
        
        photoCountLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func configure(with application: Application) {
        nameLabel.text = "\(application.name) \(application.surname)"
        iinLabel.text = "ИИН: \(application.iin)"
        photoCountLabel.text = "Фото: \(application.carPhotos.count)"
        
        switch application.status.lowercased() {
        case "pending":
            statusLabel.text = "Ожидает"
            statusLabel.backgroundColor = .orange
            statusLabel.textColor = .black
        case "approved":
            statusLabel.text = "Одобрено"
            statusLabel.backgroundColor = .green
            statusLabel.textColor = .black
        case "rejected":
            statusLabel.text = "Отклонено"
            statusLabel.backgroundColor = .red
            statusLabel.textColor = .white
        default:
            statusLabel.text = application.status
            statusLabel.backgroundColor = .gray
            statusLabel.textColor = .white
        }
    }
}

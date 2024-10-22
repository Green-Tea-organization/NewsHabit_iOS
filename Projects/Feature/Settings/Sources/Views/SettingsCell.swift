//
//  SettingsCell.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared
import SnapKit

final class SettingsCell: UICollectionViewCell, Reusable {
    // MARK: - UI Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.body1
        label.textColor = Colors.gray09
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = Fonts.body3
        label.textColor = Colors.gray04
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray03
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: SettingsCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        if viewModel.mode == .none {
            chevronImageView.isHidden = true
        }
    }
}

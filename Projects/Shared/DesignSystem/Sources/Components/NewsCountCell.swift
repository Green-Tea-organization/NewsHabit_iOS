//
//  NewsCountCell.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import SharedUtil
import SnapKit

public final class NewsCountCell: UICollectionViewCell, Reusable {
    private var selectFlag: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let checkBoxImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let countLabel = {
        let label = UILabel()
        label.font = Fonts.title3
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
        // Trait 변경 감지를 위한 등록
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            self.updateAppearance()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }
    
    private func setupLayout() {
        contentView.addSubview(checkBoxImageView)
        checkBoxImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxImageView.snp.trailing).offset(14)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: NewsCountCellViewModel) {
        countLabel.text = "\(viewModel.newsCount.rawValue)개"
        selectFlag = viewModel.isSelected
    }
    
    private func updateAppearance() {
        checkBoxImageView.image = selectFlag ? Images.checkActive : Images.checkInactive
        countLabel.textColor = selectFlag ? Colors.primary : Colors.disabled
        backgroundColor = selectFlag ? Colors.secondary : Colors.background
        layer.borderColor = (selectFlag ? Colors.background : Colors.gray01).cgColor
    }
}

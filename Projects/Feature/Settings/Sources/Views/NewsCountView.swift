//
//  NewsCountView.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared
import SnapKit

public final class NewsCountView: UIView {
    // MARK: - Components
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "조금씩 습관을 만들어가요"
        label.font = Fonts.body3
        label.textColor = Colors.gray04
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: NewsCountCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let saveButton = SaveButton(initialEnabled: true)
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(28)
            make.height.equalTo(56)
        }
    }
}

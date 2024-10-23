//
//  NameView.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared
import SnapKit

public final class NameView: UIView {
    // MARK: - Components
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "이름은 \(Constants.maxNameLength)자까지 입력 가능해요 (공백 불가)"
        label.font = Fonts.body3
        label.textColor = Colors.gray04
        return label
    }()
    
    let textFieldView = ValidatableTextField(placeholder: "이름")
    
    let saveButton = SaveButton()
    
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
        
        addSubview(textFieldView)
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(28)
            make.height.equalTo(56)
        }
    }
}

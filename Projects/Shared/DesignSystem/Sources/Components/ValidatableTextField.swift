//
//  ValidatableTextField.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/19/24.
//

import Combine
import UIKit

import SharedUtil
import SnapKit

public final class ValidatableTextField: UIView {
    private let isValidSubject = CurrentValueSubject<Bool, Never>(false)
    public var isValidPublisher: AnyPublisher<Bool, Never> {
        isValidSubject.eraseToAnyPublisher()
    }
    
    private let validator: TextValidator
    private let maxLength: Int
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Components
    
    public lazy var textField = createTextField()
    private lazy var line = createLine()
    private lazy var captionLabel = createLabel(textColor: Colors.alertWarning)
    private lazy var indicatorLabel = createLabel(textColor: Colors.gray02, text: "0/\(maxLength)")
    
    // MARK: - Init
    
    public init(placeholder: String, validator: TextValidator) {
        self.validator = validator
        self.maxLength = Constants.maxNameLength
        
        super.init(frame: .zero)
        
        setupLayout()
        setupTextField(with: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview()
        }
        
        addSubview(indicatorLabel)
        indicatorLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel)
            make.bottom.trailing.equalToSuperview()
        }
    }
    
    private func setupTextField(with placeholder: String) {
        textField.placeholder = placeholder
        textField.textPublisher
            .dropFirst()
            .sink { [weak self] text in
                guard let self = self else { return }
                validateAndUpdateUI(text)
            }
            .store(in: &cancellables)
    }
    
    private func validateAndUpdateUI(_ text: String) {
        if let errorMessage = validator.validate(text) {
            line.backgroundColor = Colors.alertWarning
            captionLabel.text = errorMessage
            captionLabel.isHidden = false
            isValidSubject.send(false)
        } else {
            line.backgroundColor = Colors.gray02
            captionLabel.isHidden = true
            isValidSubject.send(true)
        }
        
        indicatorLabel.text = "\(text.count)/\(maxLength)"
        indicatorLabel.textColor = text.count > maxLength ? Colors.alertWarning : Colors.gray02
    }
}

private extension ValidatableTextField {
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.font = Fonts.title2
        textField.textColor = Colors.gray09
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }
    
    func createLine() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.gray02
        return view
    }
    
    func createLabel(textColor: UIColor, text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Fonts.body3
        label.textColor = textColor
        return label
    }
}

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
    private let textSubject = CurrentValueSubject<String, Never>("")
    
    public var textPublisher: AnyPublisher<String, Never> {
        textSubject.eraseToAnyPublisher()
    }
    
    private let maxLength: Int
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Components
    
    public lazy var textField = createTextField()
    private lazy var line = createLine()
    private lazy var captionLabel = createLabel(textColor: Colors.alertWarning)
    private lazy var indicatorLabel = createLabel(textColor: Colors.gray02, text: "0/\(maxLength)")
    
    // MARK: - Init
    
    public init(placeholder: String, maxLength: Int = Constants.maxNameLength) {
        self.maxLength = maxLength
        
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
            .sink { [weak self] text in
                guard let self = self else { return }
                self.textSubject.send(text)
                self.updateCharacterCount(text)
            }
            .store(in: &cancellables)
    }
    
    private func updateCharacterCount(_ text: String) {
        indicatorLabel.text = "\(text.count)/\(maxLength)"
        indicatorLabel.textColor = text.count > maxLength ?
            Colors.alertWarning : Colors.gray02
    }
    
    // MARK: - Public Methods
    
    public func updateValidation(isValid: Bool, errorMessage: String?) {
        line.backgroundColor = isValid ? Colors.gray02 : Colors.alertWarning
        captionLabel.text = errorMessage
        captionLabel.isHidden = errorMessage == nil
    }
    
    public func updateText(_ text: String) {
        textField.text = text
        updateCharacterCount(text)
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

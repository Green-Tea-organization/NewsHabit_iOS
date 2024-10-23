//
//  NameViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import Combine
import UIKit

import Shared

public final class NameViewController: ViewController<NameView> {
    private let viewModel: NameViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(viewModel: NameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(title: "이름")
        setupBindings()
        setupTextField()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // Action
        nameTextField.textPublisher
            .dropFirst()
            .sink { [weak self] text in
                self?.viewModel.send(.updateUsername(text))
            }
            .store(in: &cancellables)
        
        saveButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.saveUsername)
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.adjustSaveButtonPosition(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.resetSaveButtonPosition()
            }.store(in: &cancellables)
        
        // State
        viewModel.state.validState
            .sink { [weak self] state in
                self?.nameTextField.updateValidation(
                    isValid: state.isValid,
                    errorMessage: state.message
                )
                self?.saveButton.isEnabled = state.isValid
            }
            .store(in: &cancellables)
    }
    
    private func setupTextField() {
        nameTextField.textField.text = viewModel.state.username.value
        nameTextField.textField.becomeFirstResponder()
    }
    
    private func adjustSaveButtonPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.35) {
            self.saveButton.transform = CGAffineTransform(
                translationX: 0,
                y: self.tabBarHeight - keyboardHeight
            )
        }
    }
    
    private func resetSaveButtonPosition() {
        UIView.animate(withDuration: 0.35) {
            self.saveButton.transform = .identity
        }
    }
}

private extension NameViewController {
    var nameTextField: ValidatableTextField {
        contentView.textFieldView
    }
    
    var saveButton: SaveButton {
        contentView.saveButton
    }
}
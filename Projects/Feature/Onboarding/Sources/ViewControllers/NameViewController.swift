//
//  NameViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/19/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class NameViewController: ViewController<NameView> {
    private let viewModel: NameViewModel
    public weak var delegate: NameViewControllerDelegate?
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
        setupNormalNavigationBar(rightTitle: "다음", isBackButtonHidden: true)
        rightButton?.isEnabled = false
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // Action
        nameTextField.textPublisher
            .sink { [weak self] text in
                self?.viewModel.send(.updateUsername(text))
            }
            .store(in: &cancellables)
        
        rightButton?.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.saveUsername)
                self?.delegate?.nameViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        // State
        viewModel.state.validState
            .dropFirst()
            .sink { [weak self] state in
                self?.nameTextField.updateValidation(
                    isValid: state.isValid,
                    errorMessage: state.message
                )
                self?.rightButton?.isEnabled = state.isValid
            }
            .store(in: &cancellables)
    }
}

private extension NameViewController {
    var nameTextField: ValidatableTextField {
        contentView.textFieldView
    }
}

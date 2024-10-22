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
    public weak var delegate: NameViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(rightTitle: "다음", isBackButtonHidden: true)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        nameTextField.isValidPublisher
            .sink { [weak self] isValid in
                self?.rightButton?.isEnabled = isValid
            }
            .store(in: &cancellables)
        
        rightButton?.tapPublisher
            .sink { [weak self] in
                self?.delegate?.nameViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension NameViewController {
    var nameTextField: ValidatableTextField {
        contentView.textFieldView
    }
}

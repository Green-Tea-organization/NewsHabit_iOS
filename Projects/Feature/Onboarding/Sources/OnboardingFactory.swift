//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/22/24.
//

import UIKit

import Core

public final class OnboardingFactory {
    private let userSettingsRepository: UserSettingsRepositoryProtocol
    
    public init(userSettingsRepository: UserSettingsRepositoryProtocol) {
        self.userSettingsRepository = userSettingsRepository
    }
    
    public func makeNameViewController() -> NameViewController {
        let viewModel = NameViewModel(userSettingsRepository: userSettingsRepository)
        return NameViewController(viewModel: viewModel)
    }
    
    public func makeCategoryViewController() -> CategoryViewController {
        let viewModel = CategoryViewModel(userSettingsRepository: userSettingsRepository)
        return CategoryViewController(viewModel: viewModel)
    }
    
    public func makeNewsCountViewController() -> NewsCountViewController {
        return NewsCountViewController()
    }
}


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
        return NameViewController()
    }
    
    public func makeCategoryViewController() -> CategoryViewController {
        return CategoryViewController()
    }
    
    public func makeNewsCountViewController() -> NewsCountViewController {
        return NewsCountViewController()
    }
}


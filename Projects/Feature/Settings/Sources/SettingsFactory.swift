//
//  SettingsFactory.swift
//  FeatureSettings
//
//  Created by 지연 on 10/23/24.
//

import UIKit

import Core

public final class SettingsFactory {
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
        let viewModel = NewsCountViewModel(userSettingsRepository: userSettingsRepository)
        return NewsCountViewController(viewModel: viewModel)
    }
    
    public func makeNotificationViewController() -> NotificationViewController {
        return NotificationViewController()
    }
}
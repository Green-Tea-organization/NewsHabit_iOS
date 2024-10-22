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
        return CategoryViewController()
    }
    
    public func makeNewsCountViewController() -> NewsCountViewController {
        return NewsCountViewController()
    }
    
    public func makeNotificationViewController() -> NotificationViewController {
        return NotificationViewController()
    }
}

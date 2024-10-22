//
//  MainFactory.swift
//  newshabit
//
//  Created by 지연 on 10/23/24.
//

import UIKit

import Core
import Feature

public final class MainFactory {
    private let userSettingsRepository: UserSettingsRepositoryProtocol
    
    public init(userSettingsRepository: UserSettingsRepositoryProtocol) {
        self.userSettingsRepository = userSettingsRepository
    }
    
    public func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    public func makeHotViewController() -> HotViewController {
        return HotViewController()
    }
    
    public func makeSettingsViewController() -> SettingsViewController {
        let factory = SettingsFactory(userSettingsRepository: userSettingsRepository)
        let viewModel = SettingsViewModel(userSettingsRepository: userSettingsRepository)
        return SettingsViewController(factory: factory, viewModel: viewModel)
    }
}

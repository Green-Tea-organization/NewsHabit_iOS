//
//  SettingsViewModel.swift
//  FeatureSettings
//
//  Created by 지연 on 10/23/24.
//

import Combine
import Foundation

import Core
import Shared

public final class SettingsViewModel: ViewModel {
    public enum Action {
        case selectSettings(index: Int)
    }
    
    public struct State {
        public let settings: CurrentValueSubject<[SettingsSectionViewModel], Never>
        public let selectedSettingType: CurrentValueSubject<SettingsType?, Never>
        
        public init(
            settings: [SettingsSectionViewModel] = [],
            selectedSettingsType: SettingsType? = nil
        ) {
            self.settings = .init(settings)
            self.selectedSettingType = .init(selectedSettingsType)
        }
    }
    
    // MARK: - Properties
    
    public var actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) public var state: State
    
    private var userSettingsRepository: UserSettingsRepositoryProtocol
    
    // MARK: - Init
    
    public init(userSettingsRepository: UserSettingsRepositoryProtocol) {
        self.userSettingsRepository = userSettingsRepository
        self.state = State()
        updateSettings()
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .selectSettings(let index):
            state.selectedSettingType.send(SettingsType.allCases[index])
        }
    }
    
    private func updateSettings() {
        let settingsData = SettingsData(
            username: userSettingsRepository.username,
            categories: userSettingsRepository.categories,
            newsCount: userSettingsRepository.newsCount,
            notificationEnabled: userSettingsRepository.notificationEnabled,
            notificationTime: userSettingsRepository.notificationTime
        )
        state.settings.send(SettingsType.makeSectionViewModels(settingsData: settingsData))
    }
}

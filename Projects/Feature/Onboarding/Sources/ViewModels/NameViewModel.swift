//
//  NameViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/22/24.
//

import Combine
import Foundation

import Core
import Shared

public final class NameViewModel: ViewModel {
    public enum Action {
        case updateUsername(_ name: String)
        case saveUsername
    }
    
    public struct State {
        public let username: CurrentValueSubject<String, Never>
        public let validState: CurrentValueSubject<ValidState, Never>
        
        public struct ValidState {
            public let isValid: Bool
            public let message: String?
            
            public static let initial = ValidState(isValid: false, message: nil)
        }
        
        public init(
            username: CurrentValueSubject<String, Never> = .init(""),
            validState: CurrentValueSubject<ValidState, Never> = .init(.initial)
        ) {
            self.username = username
            self.validState = validState
        }
    }
    
    // MARK: - Properties
    
    public var actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) public var state: State
    
    private var userSettingsRepository: UserSettingsRepositoryProtocol
    private let validator: TextValidator
    
    // MARK: - Init
    
    init(
        userSettingsRepository: UserSettingsRepositoryProtocol,
        validator: TextValidator = NameValidator()
    ) {
        self.userSettingsRepository = userSettingsRepository
        self.validator = validator
        self.state = State()
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .updateUsername(let name):
            let errorMessage = validator.validate(name)
            state.username.send(name)
            state.validState.send(
                State.ValidState(
                    isValid:errorMessage == nil,
                    message: errorMessage
                )
            )
        case .saveUsername:
            userSettingsRepository.username = state.username.value
        }
    }
}

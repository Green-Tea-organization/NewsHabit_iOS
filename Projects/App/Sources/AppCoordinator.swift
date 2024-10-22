//
//  AppCoordinator.swift
//  newshabit
//
//  Created by 지연 on 10/22/24.
//

import UIKit

import Core
import Feature
import Shared

public final class AppCoordinator: Coordinator {
    private let window: UIWindow
    
    private let userSettingsRepository: UserSettingsRepositoryProtocol
    
    private var onboardingCoordinator: OnboardingCoordinator?
//    private var mainCoordinator: MainCoordinator?

    public init(window: UIWindow) {
        self.window = window
        self.userSettingsRepository = UserSettingsRepository()
    }

    public func start() {
        if needsOnboarding() {
            showOnboarding()
        } else {
            showMain()
        }
    }

    private func needsOnboarding() -> Bool {
        return !userSettingsRepository.onboardingCompleted
    }

    private func showOnboarding() {
        let factory = OnboardingFactory(userSettingsRepository: userSettingsRepository)
        let coordinator = OnboardingCoordinator(window: window, factory: factory)
        coordinator.delegate = self
        coordinator.start()
        self.onboardingCoordinator = coordinator
    }

    private func showMain() {
        print("완료")
//        let mainCoordinator = MainCoordinator(window: window)
//        mainCoordinator.start()
//        self.mainCoordinator = mainCoordinator
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    public func onboardingCoordinatorDidFinish() {
        showMain()
    }
}

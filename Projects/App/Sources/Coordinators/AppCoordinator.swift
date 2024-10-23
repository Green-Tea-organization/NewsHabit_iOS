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
    private var onboardingCoordinator: OnboardingCoordinator?
    private var mainCoordinator: MainCoordinator?
    
    private var userSettingsRepository: UserSettingsRepositoryProtocol

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
        userSettingsRepository.onboardingCompleted = true
        print("✅ 온보딩 완료")
        print("사용자 이름 : \(userSettingsRepository.username)")
        print("카테고리 : \(userSettingsRepository.categories)")
        print("기사 개수 : \(userSettingsRepository.newsCount)")
        let factory = MainFactory(userSettingsRepository: userSettingsRepository)
        let mainCoordinator = MainCoordinator(window: window, factory: factory)
        mainCoordinator.start()
        self.mainCoordinator = mainCoordinator
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    public func onboardingCoordinatorDidFinish() {
        showMain()
    }
}

//
//  OnboardingCoordinator.swift
//  Onboarding
//
//  Created by 지연 on 10/22/24.
//

import UIKit

import FeatureOnboardingInterface
import Shared

public final class OnboardingCoordinator: Coordinator {
    private let window: UIWindow
    private let factory: OnboardingFactory
    
    private var navigationController: UINavigationController?
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    public init(window: UIWindow, factory: OnboardingFactory) {
        self.window = window
        self.factory = factory
    }
    
    public func start() {
        let nameViewController = factory.makeNameViewController()
        nameViewController.delegate = self
        navigationController = UINavigationController(rootViewController: nameViewController)
        window.rootViewController = navigationController
    }
    
    private func showCategoryViewController() {
        let categoryViewController = factory.makeCategoryViewController()
        categoryViewController.delegate = self
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    private func showNewsCountViewController() {
        let newsCountViewController = factory.makeNewsCountViewController()
        newsCountViewController.delegate = self
        navigationController?.pushViewController(newsCountViewController, animated: true)
    }
}

extension OnboardingCoordinator: NameViewControllerDelegate {
    public func nameViewControllerDidFinish() {
        showCategoryViewController()
    }
}

extension OnboardingCoordinator: CategoryViewControllerDelegate {
    public func categoryViewControllerDidFinish() {
        showNewsCountViewController()
    }
}

extension OnboardingCoordinator: NewsCountViewControllerDelegate {
    public func newsCountViewControllerDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}

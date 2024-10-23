//
//  MainCoordinator.swift
//  newshabit
//
//  Created by 지연 on 10/23/24.
//

import UIKit

import Shared

public final class MainCoordinator: Coordinator {
    private let window: UIWindow
    private let factory: MainFactory
    
    private var navigationController: UINavigationController?
    
    init(window: UIWindow, factory: MainFactory) {
        self.window = window
        self.factory = factory
    }
    
    public func start() {
        let tabBarController = TabBarController(factory: factory)
        navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
    }
}

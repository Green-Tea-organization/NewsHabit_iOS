//
//  SceneDelegate.swift
//  newshabit
//
//  Created by 지연 on 10/18/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(window: window)
        
        self.window = window
    }
}

extension SceneDelegate: SplashDelegate {
    func didFinish() {
        appCoordinator?.start()
    }
}

//
//  SceneDelegate.swift
//  FeatureHomeExample
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import FeatureHome

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(
            rootViewController: HomeViewController()
        )
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

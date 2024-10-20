//
//  TabBarController.swift
//  newshabit
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

final class TabBarController: UITabBarController {
    private enum Tab: CaseIterable {
        case home
        case hot
        case settings
        
        var activeImage: UIImage {
            switch self {
            case .home:     Images.homeActive
            case .hot:      Images.newsActive
            case .settings: Images.settingsActive
            }
        }
        
        var inactiveImage: UIImage {
            switch self {
            case .home:     Images.homeInactive
            case .hot:      Images.newsInactive
            case .settings: Images.settingsInactive
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = Colors.background
        tabBar.tintColor = Colors.gray09
        tabBar.unselectedItemTintColor = Colors.gray09
        
        viewControllers = Tab.allCases.map { tab in
            let viewController = ViewController()
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: tab.inactiveImage,
                selectedImage: tab.activeImage
            )
            return UINavigationController(rootViewController: viewController)
        }
    }
}
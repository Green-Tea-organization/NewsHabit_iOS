//
//  TabBarController.swift
//  newshabit
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Feature
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
    
    private let factory: MainFactory
    
    // MARK: - Init
    
    public init(factory: MainFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let viewController: UIViewController
            
            switch tab {
            case .home:     viewController = factory.makeHomeViewController()
            case .hot:      viewController = factory.makeHotViewController()
            case .settings: viewController = factory.makeSettingsViewController()
            }
            
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: tab.inactiveImage,
                selectedImage: tab.activeImage
            )
            return UINavigationController(rootViewController: viewController)
        }
    }
}

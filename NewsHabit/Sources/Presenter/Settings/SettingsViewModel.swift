//
//  SettingsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

class SettingsViewModel {
    
    // MARK: - Properties
    
    var settingsItems: [SettingsItem] = [
        SettingsItem(
            image: UIImage(systemName: "person.fill"),
            title: "프로필"
        ),
        SettingsItem(
            image: UIImage(systemName: "newspaper"),
            title: "나의 뉴빗"
        ),
        SettingsItem(
            image: UIImage(systemName: "bell"),
            title: "알림"
        ),
        SettingsItem(
            image: UIImage(systemName: "sun.max"),
            title: "테마"
        ),
        SettingsItem(
            image: UIImage(systemName: "info.circle"),
            title: "개발자 정보"
        )
    ]

}
//
//  SettingsData.swift
//  FeatureSettings
//
//  Created by 지연 on 10/23/24.
//

import Foundation

import Shared

public struct SettingsData {
    public let username: String
    public let categories: [SharedUtil.Category]
    public let newsCount: NewsCount
    public let notificationEnabled: Bool
    public let notificationTime: Date
    
    public init(
        username: String,
        categories: [SharedUtil.Category],
        newsCount: NewsCount,
        notificationEnabled: Bool,
        notificationTime: Date
    ) {
        self.username = username
        self.categories = categories
        self.newsCount = newsCount
        self.notificationEnabled = notificationEnabled
        self.notificationTime = notificationTime
    }
}

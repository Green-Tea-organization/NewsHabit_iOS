//
//  UserSettingsRepository.swift
//  CoreLocalStorage
//
//  Created by 지연 on 10/21/24.
//

import Foundation

import CoreLocalStorageInterface
import Shared

public struct UserSettingsRepository: UserSettingsRepositoryProtocol {
    @UserDefaultsData(key: "onboardingCompleted", defaultValue: false)
    public var onboardingCompleted: Bool
    
    @UserDefaultsData(key: "username", defaultValue: "")
    public var username: String
    
    @UserDefaultsData(key: "categories", defaultValue: [])
    public var categories: [SharedUtil.Category]
    
    @UserDefaultsData(key: "newsCount", defaultValue: NewsCount.three)
    public var newsCount: NewsCount
    
    @UserDefaultsData(key: "notificationEnabled", defaultValue: false)
    public var notificationEnabled: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: Date())
    public var notificationTime: Date
}

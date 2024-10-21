//
//  UserSettingsRepositoryProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/21/24.
//

import Foundation

import Shared

public protocol UserSettingsRepositoryProtocol {
    var onboardingCompleted: Bool { get set }
    var username: String { get set }
    var categories: [SharedUtil.Category] { get set }
    var newsCount: NewsCount { get set }
    var notificationEnabled: Bool { get set }
    var notificationTime: Date { get set }
}

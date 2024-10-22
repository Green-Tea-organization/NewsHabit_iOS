//
//  SettingsType.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import Foundation

import Core

public enum SettingsType: String, CaseIterable {
    case name = "이름"
    case category = "카테고리"
    case newsCount = "기사 개수"
    case notification = "알림"
    case developer = "개발자 정보"
    case reset = "데이터 초기화"
    
    public enum Mode {
        case none
        case chevron
        case description
    }
    
    public var mode: Mode {
        switch self {
        case .developer:    .chevron
        case .reset:        .none
        default:            .description
        }
    }
    
    public func makeDescription(settingsData: SettingsData) -> String? {
        switch self {
        case .name:
            return settingsData.username
        case .category:
            let categories = settingsData.categories
            let firstCategory = categories[0]
            if categories.count == 1 {
                return firstCategory.name
            } else {
                return "\(firstCategory.name) 외 \(categories.count - 1)개"
            }
        case .newsCount:
            return "\(settingsData.newsCount.rawValue)개"
        case .notification:
            return settingsData.notificationEnabled ?
            settingsData.notificationTime.formatAsTimeWithPeriod() :
            "OFF"
        case .developer:
            return nil
        case .reset:
            return nil
        }
    }
    
    static func makeSectionViewModels(
        settingsData: SettingsData
    ) -> [SettingsSectionViewModel] {
        [
            SettingsSectionViewModel(
                index: 0,
                cellViewModels: [Self.name, Self.category, Self.newsCount, Self.notification]
                    .map { type in
                        SettingsCellViewModel(
                            title: type.rawValue,
                            description: type.makeDescription(settingsData: settingsData),
                            mode: type.mode
                        )
                    }
            )
            ,
            SettingsSectionViewModel(
                index: 1,
                cellViewModels: [Self.developer, Self.reset]
                    .map { type in
                        SettingsCellViewModel(
                            title: type.rawValue,
                            description: type.makeDescription(settingsData: settingsData),
                            mode: type.mode
                        )
                    }
            )
        ]
    }
}

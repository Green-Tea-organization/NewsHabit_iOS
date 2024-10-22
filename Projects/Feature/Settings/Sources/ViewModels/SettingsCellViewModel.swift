//
//  SettingsCellViewModel.swift
//  FeatureSettings
//
//  Created by 지연 on 10/23/24.
//

import Foundation

public struct SettingsCellViewModel: Hashable {
    public let title: String
    public var description: String?
    public let mode: SettingsType.Mode
    
    public init(title: String, description: String? = nil, mode: SettingsType.Mode) {
        self.title = title
        self.description = description
        self.mode = mode
    }
}

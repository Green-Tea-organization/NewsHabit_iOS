//
//  SettingsSectionViewModel.swift
//  FeatureSettings
//
//  Created by 지연 on 10/23/24.
//

import Foundation

public struct SettingsSectionViewModel: Hashable {
    public let index: Int
    public let cellViewModels: [SettingsCellViewModel]
}

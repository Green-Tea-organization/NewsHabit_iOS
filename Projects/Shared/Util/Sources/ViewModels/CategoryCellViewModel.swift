//
//  CategoryCellViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public struct CategoryCellViewModel: Hashable {
    public let category: Category
    public var isSelected: Bool
    
    public init(category: Category, isSelected: Bool = false) {
        self.category = category
        self.isSelected = isSelected
    }
}

//
//  NewsCountCellViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public struct NewsCountCellViewModel: Hashable {
    public let newsCount: NewsCount
    public var isSelected: Bool
    
    public init(newsCount: NewsCount, isSelected: Bool) {
        self.newsCount = newsCount
        self.isSelected = isSelected
    }
}

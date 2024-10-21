//
//  NewsItem.swift
//  SharedUtil
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public struct NewsItem {
    public let id: UUID
    public let title: String
    public let content: String
    public let category: String
    public let url: String
    public let imageURL: String
    public var isRead: Bool
    public var isBookmarked: Bool
    
    public init(
        id: UUID = .init(),
        title: String,
        content: String,
        category: String,
        url: String,
        imageURL: String,
        isRead: Bool = false,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.category = category
        self.url = url
        self.imageURL = imageURL
        self.isRead = isRead
        self.isBookmarked = isBookmarked
    }
}

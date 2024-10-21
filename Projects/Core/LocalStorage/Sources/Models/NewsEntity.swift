//
//  NewsEntity.swift
//  CoreLocalStorage
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import RealmSwift
import Shared

public final class NewsEntity: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var category: String
    @Persisted var url: String
    @Persisted var imageURL: String
    @Persisted var isRead: Bool
    @Persisted var isBookmarked: Bool
    
    public convenience init(_ item: NewsItem) {
        self.init()
        id = item.id
        title = item.title
        content = item.content
        category = item.category
        url = item.url
        imageURL = item.imageURL
        isRead = item.isRead
        isBookmarked = item.isBookmarked
    }
}

extension NewsEntity {
    public func toDomain() -> NewsItem {
        return NewsItem(
            id: id,
            title: title,
            content: content,
            category: category,
            url: url,
            imageURL: imageURL,
            isRead: isRead,
            isBookmarked: isBookmarked
        )
    }
}

//
//  BookmarkRepositoryProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import Shared

public protocol BookmarkRepositoryProtocol {
    func fetchBookmarkedNews() -> [NewsItem]
    func saveNewsItem(_ item: NewsItem) throws
    func deleteNewsItem(with id: UUID) throws
    func isNewsItemBookmarked(with id: UUID) -> Bool
}

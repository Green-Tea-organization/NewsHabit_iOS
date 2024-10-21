//
//  DailyNewsRepositoryProtocol.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import Shared

public protocol DailyNewsRepositoryProtocol {
    func fetchDailyNews() -> [NewsItem]
    func saveDailyNews(_ items: [NewsItem]) throws
    func updateNewsItem(_ item: NewsItem) throws
}

//
//  DailyNewsRepository.swift
//  CoreLocalStorage
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import CoreLocalStorageInterface
import RealmSwift
import Shared

public final class DailyNewsRepository: DailyNewsRepositoryProtocol {
    private let realm: Realm
    
    public init() {
        do {
            let configuration = Realm.Configuration(
                fileURL: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                    .first!
                    .appendingPathComponent("caching.realm")
            )
            realm = try Realm(configuration: configuration)
        } catch {
            fatalError(RealmError.realmNotInitialized.localizedDescription)
        }
    }
    
    public func fetchDailyNews() -> [NewsItem] {
        let newsEntities = realm.objects(NewsEntity.self)
        let newsItems = Array(newsEntities).map { $0.toDomain() }
        return newsItems
    }
    
    public func saveDailyNews(_ items: [NewsItem]) throws {
        try deleteDailyNews()
        do {
            try realm.write {
                let newsEntities = items.map { NewsEntity($0) }
                realm.add(newsEntities)
            }
        } catch {
            throw RealmError.failedToSave
        }
    }
    
    public func updateNewsItem(_ item: NewsItem) throws {
        do {
            try realm.write {
                let newsEntity = NewsEntity(item)
                realm.add(newsEntity, update: .modified)
            }
        } catch {
            throw RealmError.failedToUpdate
        }
    }
    
    private func deleteDailyNews() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw RealmError.failedToDelete
        }
    }
}

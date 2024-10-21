//
//  BookmarkRepository.swift
//  CoreLocalStorage
//
//  Created by 지연 on 10/22/24.
//

import Foundation

import CoreLocalStorageInterface
import RealmSwift
import Shared

public final class BookmarkRepository: BookmarkRepositoryProtocol {
    private let realm: Realm
    
    public init() {
        do {
            let configuration = Realm.Configuration(
                fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    .first!
                    .appendingPathComponent("persistent.realm")
            )
            realm = try Realm(configuration: configuration)
        } catch {
            fatalError(RealmError.realmNotInitialized.localizedDescription)
        }
    }
    
    public func fetchBookmarkedNews() -> [SharedUtil.NewsItem] {
        let newsEntities = realm.objects(NewsEntity.self)
        let newsItems = Array(newsEntities).map { $0.toDomain() }
        return newsItems
    }
    
    public func saveNewsItem(_ item: SharedUtil.NewsItem) throws {
        do {
            try realm.write {
                let newsEntity = NewsEntity(item)
                realm.add(newsEntity, update: .modified)
            }
        } catch {
            throw RealmError.failedToSave
        }
    }
    
    public func deleteNewsItem(with id: UUID) throws {
        guard let newsEntity = realm.object(ofType: NewsEntity.self, forPrimaryKey: id) else {
            throw RealmError.itemNotFound
        }
        
        do {
            try realm.write {
                realm.delete(newsEntity)
            }
        } catch {
            throw RealmError.failedToDelete
        }
    }
    
    public func isNewsItemBookmarked(with id: UUID) -> Bool {
        if let _ = realm.object(ofType: NewsEntity.self, forPrimaryKey: id) {
            return true
        } else {
            return false
        }
    }
}

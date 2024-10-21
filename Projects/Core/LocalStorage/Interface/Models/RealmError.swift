//
//  RealmError.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/22/24.
//

import Foundation

public enum RealmError: Error {
    case realmNotInitialized
    case failedToSave
    case failedToUpdate
    case failedToDelete
    case itemNotFound
    
    var errorDescription: String {
        switch self {
        case .realmNotInitialized:
            return "Realm database is not initialized"
        case .failedToSave:
            return "Failed to save"
        case .failedToUpdate:
            return "Failed to update"
        case .failedToDelete:
            return "Failed to delete"
        case .itemNotFound:
            return "Item not found in Realm"
        }
    }
}

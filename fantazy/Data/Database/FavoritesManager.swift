//
//  FavoritesManager.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 11/05/2026.
//

import CoreData

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let context = PersistenceController.shared.context
    
    private init() {}
    
    func fetchFavorites() -> [FavoriteLeague] {
        []
    }
    
    func addFavorite(id: Int, name: String, logo: String, country: String) {}
    
    func removeFavorite(id: Int) {}
    
    func toggleFavorite(id: Int, name: String, logo: String, country: String) {}
    
    func isFavorite(id: Int) -> Bool {
        return false
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
    }
    
}

//
//  LeagueDAO.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 11/05/2026.
//

import CoreData

class LeagueDAO {
    
    static let shared = LeagueDAO()
    
    private let context = PersistenceController.shared.context
    
    private init() {}
    
    func fetchFavorites() -> [FavoriteLeague] {
        
        //Todo
      return []
    }
    
    func addFavorite(id: Int, name: String, logo: String, country: String) {
        //Todo
    }
    
    func removeFavorite(id: Int) {
        //Todo
    }
    
    func toggleFavorite(id: Int, name: String, logo: String, country: String) {
        //Todo
    }
    
    func isFavorite(id: Int) -> Bool {

        //Todo
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

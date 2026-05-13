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
    
    func removeFavorite(id: Int) {
        //Todo
    }
    
    func toggleFavorite(id: Int, name: String, logo: String, country: String) {
        if(isFavorite(id: id)){
            removeFavorite(id: id)
        }else{
            addFavorite(id: id, name: name, logo: logo, country: country)
        }
    }
    
    func addFavorite(id: Int, name: String, logo: String, country: String) {
        guard !isFavorite(id: id) else { return } // prevent duplicates
        
        let favorite = FavoriteLeague(context: context)
        favorite.id = Int32(id)
        favorite.name = name
        favorite.logo = logo
        favorite.country = country
        
        saveContext()
    }

    func isFavorite(id: Int) -> Bool {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check favorite: \(error)")
            return false
        }
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

import Foundation

class LocalDataSource: LocalDataSourceProtocol {
    let leagueDao: LeagueDAO
    
    init(leagueDao: LeagueDAO){
        self.leagueDao = leagueDao
    }
    
    func addLeagueToFavorite(league: League) {
        leagueDao.addFavorite(
            id: Int(league.id ?? "0") ?? 0,
            name: league.name ?? "",
            logo: league.badgeURL ?? "",
            country: league.countryName ?? ""
        )
    }

    func isLeagueFavorite(leagueId: String) -> Bool {
        return leagueDao.isFavorite(id: Int(leagueId) ?? 0)
    }
}

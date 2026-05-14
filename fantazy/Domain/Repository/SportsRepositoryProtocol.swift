protocol SportsRepositoryProtocol {
    func getLeagues(for sport: SportType) async throws -> [League]
    func getLeagueDetails(for sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [LatestResult])
    func getTeamDetails(for sport: SportType, teamName: String) async throws -> TeamDetails
    
    func addLeagueToFavorite(league: League)
    func isLeagueFavorite(id: String) -> Bool
    
    func removeLeagueFromFavorite(leagueId: String)
    func getAllFavorites() -> [FavoriteLeague]
}

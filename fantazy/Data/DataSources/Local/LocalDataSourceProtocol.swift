protocol LocalDataSourceProtocol{
    func addLeagueToFavorite(league: League)
    func isLeagueFavorite(leagueId: String) -> Bool
    func removeLeagueFromFavorite(leagueId: String)
    func getAllFavorites() -> [FavoriteLeague]
}

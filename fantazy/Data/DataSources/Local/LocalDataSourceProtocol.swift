protocol LocalDataSourceProtocol{
    func addLeagueToFavorite(league: League)
    func isLeagueFavorite(leagueId: String) -> Bool
}

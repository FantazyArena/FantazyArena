protocol RemoteDataSourceProtocol {
    func fetchLeagues(sport: SportType) async throws -> [League]
    
    func fetchLeagueDetails(sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest:[LatestResult])
    
    func fetchTeamDetails(sport: SportType, teamName: String) async throws -> TeamDetails
}

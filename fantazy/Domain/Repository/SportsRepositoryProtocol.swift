protocol SportsRepositoryProtocol {
    func getLeagues(for sport: SportType) async throws -> [League]
    func getLeagueDetails(for sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [Event])
    func getTeamDetails(for sport: SportType, teamName: String) async throws -> TeamDetails
}

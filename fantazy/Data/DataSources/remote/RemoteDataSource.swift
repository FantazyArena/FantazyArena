class RemoteDataSource: RemoteDataSourceProtocol {
    
    private let teamDetailsService: TeamDetailsAPIServiceProtocol
    
    init(teamDetailsService: TeamDetailsAPIServiceProtocol = TeamDetailsAPIService.shared) {
        self.teamDetailsService = teamDetailsService
    }
    
    func fetchLeagues(sport: SportType) async throws -> [League] {
        return []
    }
    
    func fetchLeagueDetails(sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [Event]) {
        return ([], [], [])
    }
    
    func fetchTeamDetails(sport: SportType, teamName: String) async throws -> TeamDetails {
        return TeamDetails(thumbnail: "", name: "", founded: "", stadium: "", national: "", players: [])
    }
}

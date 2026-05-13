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
        do{
            switch(sport){
                case .basketball:
                guard let dto = try await teamDetailsService.getBasketballTeamDetails(name: teamName) else{
                    return TeamDetails(thumbnail: "", name: "", founded: "", national: "", players: [])
                }
                return BasketballTeamDetailsMapper.toTeam(dto)
                
                case .football:
                guard let dto = try await teamDetailsService.getFootballTeamDetails(name: teamName) else{
                    return TeamDetails(thumbnail: "", name: "", founded: "", national: "", players: [])
                    }
                    return FootballTeamDetailsMapper.toTeam(dto)
                }
        }catch{
            print("Remote data source: Error \(error.localizedDescription)")
            return TeamDetails(thumbnail: "", name: "", founded: "", national: "", players: [])
        }
    }
}

class RemoteDataSource: RemoteDataSourceProtocol {
    
    private let teamDetailsService: TeamDetailsAPIServiceProtocol
    private let footballService : SportService
    private let basketballService : SportService

    init(
         teamDetailsService: TeamDetailsAPIServiceProtocol = TeamDetailsAPIService.shared,
         footballService :SportService = FootballAPIService.shared,
         basketballService :SportService = BasketballAPIService.shared
    ) {
        self.teamDetailsService = teamDetailsService
        self.footballService = footballService
        self.basketballService = basketballService
    }
    
    func fetchLeagues(sport: SportType) async throws -> [League] {
        do{
            switch(sport){
                case .basketball:
                 let result = try await basketballService.getLeagues()
                return result
                
              case .football:
                let result = try await footballService.getLeagues()
               
                return result
                
                }
            } catch{
                print("Remote data source: Error \(error.localizedDescription)")
                return []
            
            }
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

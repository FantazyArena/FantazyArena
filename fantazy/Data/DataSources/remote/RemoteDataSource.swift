import Foundation

class RemoteDataSource: RemoteDataSourceProtocol {
    
    private let teamDetailsService: TeamDetailsAPIServiceProtocol
    private let footballService : SportService
    private let basketballService : SportService
    private let calendar = Calendar.current

    init(
        teamDetailsService: TeamDetailsAPIServiceProtocol = TeamDetailsAPIService.shared,
        footballService : SportService = FootballAPIService.shared,
        basketballService : SportService = BasketballAPIService.shared
    ) {
        self.teamDetailsService = teamDetailsService
        self.footballService = footballService
        self.basketballService = basketballService
    }
    
    func fetchLeagues(sport: SportType) async throws -> [League] {
        switch sport {
        case .basketball:
            return try await basketballService.getLeagues()
        case .football:
            return try await footballService.getLeagues()
        }
    }
    
    func fetchLeagueDetails(sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [LatestResult]) {
        switch sport {
        case .basketball:
            return try await getBasketballLeagueDetails(leagueID: leagueId)
        case .football:
            return try await getFootballLeagueDetails(leagueId: leagueId)
        }
    }
    
    private func getFootballLeagueDetails(leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest:[LatestResult]) {
        let today = Date()
        let fifteenDaysFromNow = calendar.date(byAdding: .day, value: 15, to: today)!
        let fifteenDaysAgo = calendar.date(byAdding: .day, value: -15, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let todayStr = formatter.string(from: today)
        let fifteenDaysFromNowStr = formatter.string(from: fifteenDaysFromNow)
        let fifteenDaysAgoStr = formatter.string(from: fifteenDaysAgo)

        let teams = try await footballService.getTeams(leagueId: leagueId)
        
        let upcomingMatches = try await footballService.getFixtures(
            leagueId: leagueId,
            from: todayStr,
            to: fifteenDaysFromNowStr
        )
        
        let latestMatches =  try await footballService.getLatestResults(
            leagueId: leagueId,
            from: fifteenDaysAgoStr,
            to: todayStr
        )
        
        return (teams, upcomingMatches, latestMatches)
    }
    
    private let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private func getBasketballLeagueDetails(leagueID: Int) async throws -> (teams: [Team], upcoming: [Event], latest:[LatestResult]) {
        let today = Date()
        let fifteenDaysFromNow = calendar.date(byAdding: .day, value: 15, to: today)!
        let fifteenDaysAgo = calendar.date(byAdding: .day, value: -15, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let todayStr = formatter.string(from: today)
        let fifteenDaysFromNowStr = formatter.string(from: fifteenDaysFromNow)
        let fifteenDaysAgoStr = formatter.string(from: fifteenDaysAgo)

        let teams = try await basketballService.getTeams(leagueId: leagueID)
        
        let upcomingMatches = try await basketballService.getFixtures(
            leagueId: leagueID,
            from: todayStr,
            to: fifteenDaysFromNowStr
        )
        
        let latestMatches = try await basketballService.getLatestResults(
            leagueId: leagueID,
            from: fifteenDaysAgoStr,
            to: todayStr
        )
        
        return (teams, upcomingMatches, latestMatches)
    }
    
    func fetchTeamDetails(sport: SportType, teamName: String) async throws -> TeamDetails {
        switch sport {
        case .basketball:
            guard let dto = try await teamDetailsService.getBasketballTeamDetails(name: teamName) else {
                return emptyTeamDetails()
            }
            return BasketballTeamDetailsMapper.toTeam(dto)
            
        case .football:
            guard let dto = try await teamDetailsService.getFootballTeamDetails(name: teamName) else {
                return emptyTeamDetails()
            }
            return FootballTeamDetailsMapper.toTeam(dto)
        }
    }

    private func emptyTeamDetails() -> TeamDetails {
        return TeamDetails(thumbnail: "", name: "", founded: "", national: "", players: [])
    }
}

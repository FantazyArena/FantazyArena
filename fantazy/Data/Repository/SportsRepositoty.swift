import Foundation

final class SportsRepository: SportsRepositoryProtocol {
    
    static let shared = SportsRepository()
    
    //TODO: add local data source
    
    private let remoteDataSource: RemoteDataSourceProtocol

    private init(
        remoteDataSource: RemoteDataSourceProtocol = RemoteDataSource()
    ) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getLeagues(for sport: SportType) async throws -> [League] {
        return []
    }
    
    func getLeagueDetails(for sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [Event]) {
        return ([], [], [])
    }
    
    func getTeamDetails(for sport: SportType, teamName: String) async throws -> TeamDetails {
        return TeamDetails(thumbnail: "", name: "", founded: "", stadium: "", national: "", players: [])
    }
}

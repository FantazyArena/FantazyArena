import Foundation

final class SportsRepository: SportsRepositoryProtocol {
    
    static let shared = SportsRepository()
    
    private let localDataSource: LocalDataSourceProtocol
    private let remoteDataSource: RemoteDataSourceProtocol

    private init(
        remoteDataSource: RemoteDataSourceProtocol = RemoteDataSource(),
        localDataSource: LocalDataSourceProtocol = LocalDataSource(leagueDao: LeagueDAO.shared)
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getLeagues(for sport: SportType) async throws -> [League] {
        return []
    }
    
    func getLeagueDetails(for sport: SportType, leagueId: Int) async throws -> (teams: [Team], upcoming: [Event], latest: [Event]) {
        return ([], [], [])
    }
    
    func getTeamDetails(for sport: SportType, teamName: String) async throws -> TeamDetails {
        do{
            return try await remoteDataSource.fetchTeamDetails(sport: sport, teamName: teamName)
        }catch{
            print("Sport Repository: Error \(error.localizedDescription)")
            return TeamDetails(thumbnail: "", name: "", founded: "", national: "", players: [])
        }
    }
    
    func addLeagueToFavorite(league: League){
        localDataSource.addLeagueToFavorite(league: league)
    }
    
    func isLeagueFavorite(id: String) -> Bool{
        return localDataSource.isLeagueFavorite(leagueId: id)
    }
}

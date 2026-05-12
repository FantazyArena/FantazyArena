import Foundation
 
protocol SportService {
    func getLeagues() async throws -> [League]
    func getTeams(leagueId: Int) async throws -> [Team]
    func getFixtures(leagueId: Int, from: String, to: String) async throws -> [Event]
}

import Alamofire

final class FootballAPIService: SportService {

    static let shared = FootballAPIService()
    private let baseURL = ApiConfig.FOOTBALL_BASE_URL
    private let session: Session
    
    init(session: Session = .default ) {
        self.session = session
    }


    func getLeagues() async throws -> [League] {
        let dtos: [FootballLeagueDTO] = try await fetch(endpoint: LeaguesEndpoint())
        return dtos.map(FootballMapper.toLeague)
    }

    func getTeams(leagueId: Int) async throws -> [Team] {
        let dtos: [FootballTeamDTO] = try await fetch(endpoint: TeamsByLeagueEndpoint(leagueId: leagueId))
        return dtos.map(FootballMapper.toTeam)
    }

    func getFixtures(leagueId: Int, from: String, to: String) async throws -> [Event] {
        let dtos: [FootballEventDTO] = try await fetch(
            endpoint: FixturesEndpoint(leagueId: leagueId, from: from, to: to)
        )
        return dtos.map(FootballMapper.toEvent)
    }

    func getLatestResults(leagueId: Int, from: String, to: String) async throws -> [LatestResult] {
            let dtos: [FootballEventDTO] = try await fetch(
                endpoint: FixturesEndpoint(leagueId: leagueId, from: from, to: to)
            )
            return dtos.map(FootballMapper.toLatestResult)
        }
    
    func searchTeams(name: String) async throws -> [Team] {
        let dtos: [FootballTeamDTO] = try await fetch(endpoint: TeamsByNameEndpoint(teamName: name))
        return dtos.map(FootballMapper.toTeam)
    }

    private func fetch<T: Decodable>(endpoint: Endpoint) async throws -> [T] {
        let url = baseURL + endpoint.path
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: endpoint.parameters, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: AllSportsResponseDTO<T>.self) { response in
                    switch response.result {
                    case .success(let dto):
                        continuation.resume(returning: dto.result ?? [])
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}

import Alamofire

final class BasketballAPIService: SportService {

    static let shared = BasketballAPIService()
    private init() {}

    private let baseURL = ApiConfig.BASKETBALL_BASE_URL

    func getLeagues() async throws -> [League] {
        let dtos: [BasketballLeagueDTO] = try await fetch(endpoint: LeaguesEndpoint())
        return dtos.map(BasketballMapper.toLeague)
    }

    func getTeams(leagueId: Int) async throws -> [Team] {
        let dtos: [BasketballTeamDTO] = try await fetch(endpoint: TeamsByLeagueEndpoint(leagueId: leagueId))
        return dtos.map(BasketballMapper.toTeam)
    }

    func getFixtures(leagueId: Int, from: String, to: String) async throws -> [Event] {
        let dtos: [BasketballEventDTO] = try await fetch(
            endpoint: FixturesEndpoint(leagueId: leagueId, from: from, to: to)
        )
        return dtos.map(BasketballMapper.toEvent)
    }

    func getTeamById(_ id: Int) async throws -> [Team] {
        let dtos: [BasketballTeamDTO] = try await fetch(endpoint: TeamByIdEndpoint(teamId: id))
        return dtos.map(BasketballMapper.toTeam)
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

import Alamofire

protocol TeamDetailsAPIServiceProtocol {
    func getFootballTeamDetails(name: String) async throws -> FootballTeamDetailsDTO?
    func getBasketballTeamDetails(name: String) async throws -> BasketballTeamDetailsDTO?
}


final class TeamDetailsAPIService: TeamDetailsAPIServiceProtocol {

    static let shared = TeamDetailsAPIService()
    private init() {}

    func getFootballTeamDetails(name: String) async throws -> FootballTeamDetailsDTO? {
        let endpoint = TeamDetailsEndpoint(teamName: name)
        let results: [FootballTeamDetailsDTO] = try await fetch(
            baseURL: ApiConfig.FOOTBALL_TEAM_BASE_URL,
            endpoint: endpoint
        )
        return results.first
    }

    func getBasketballTeamDetails(name: String) async throws -> BasketballTeamDetailsDTO? {
        let endpoint = TeamDetailsEndpoint(teamName: name)
        let results: [BasketballTeamDetailsDTO] = try await fetch(
            baseURL: ApiConfig.BASKETBALL_TEAM_BASE_URL,
            endpoint: endpoint
        )
        return results.first
    }

    private func fetch<T: Decodable, E: Endpoint>(baseURL: String, endpoint: E) async throws -> [T] {
        let url = baseURL + endpoint.path
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: endpoint.parameters, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: APISportsResponseDTO<T>.self) { response in
                    switch response.result {
                    case .success(let dto):
                        continuation.resume(returning: dto.response ?? [])
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}

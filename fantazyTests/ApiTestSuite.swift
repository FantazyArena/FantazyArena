import XCTest
@testable import fantazy

final class ApiTestSuite: XCTestCase {

    private var networkManager: NetworkManager!
    private let footballLeagueId = 302
    private let basketballLeagueId = 757
    private let footballTeamId = 80
    private let basketballTeamId = 100
    private let from = "2024-01-01"
    private let to = "2024-12-31"

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func test_FootballLeaguesEndpoint() async throws {
        let endpoint = LeaguesEndpoint()

        let response: AllSportsResponseDTO<FootballLeagueDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .football,
            model: AllSportsResponseDTO<FootballLeagueDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let league = response.result!.first!
        XCTAssertFalse(league.leagueName.isEmpty)
    }

    func test_FootballLeagueTeamsEndpoint() async throws {
        let endpoint = TeamsByLeagueEndpoint(leagueId: footballLeagueId)

        let response: AllSportsResponseDTO<FootballTeamDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .football,
            model: AllSportsResponseDTO<FootballTeamDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let team = response.result!.first!
        XCTAssertFalse((team.teamName ?? "").isEmpty)
    }

    func test_FootballLeagueFixturesEndpoint() async throws {
        let endpoint = FixturesEndpoint(leagueId: footballLeagueId, from: from, to: to)

        let response: AllSportsResponseDTO<FootballEventDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .football,
            model: AllSportsResponseDTO<FootballEventDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let event = response.result!.first!
        XCTAssertNotNil(event.eventHomeTeam)
    }

    func test_FootballLeagueLatestResultsEndpoint() async throws {
        let endpoint = FixturesEndpoint(leagueId: footballLeagueId, from: from, to: to)

        let response: AllSportsResponseDTO<FootballEventDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .football,
            model: AllSportsResponseDTO<FootballEventDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let result = response.result!.first!
        XCTAssertNotNil(result.eventFinalResult)
    }

    func test_FootballTeamByIdEndpoint() async throws {
        let endpoint = TeamByIdEndpoint(teamId: footballTeamId)

        let response: AllSportsResponseDTO<FootballTeamDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .football,
            model: AllSportsResponseDTO<FootballTeamDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let team = response.result!.first!
        XCTAssertEqual(team.teamKey, footballTeamId)
    }

    func test_FootballLeagueDetails_AllEndpoints() async throws {
        let teams: AllSportsResponseDTO<FootballTeamDTO> =
        try await networkManager.request(
            endpoint: TeamsByLeagueEndpoint(leagueId: footballLeagueId),
            api: .football,
            model: AllSportsResponseDTO<FootballTeamDTO>.self
        )
        XCTAssertFalse(teams.result?.isEmpty ?? true)

        let events: AllSportsResponseDTO<FootballEventDTO> =
        try await networkManager.request(
            endpoint: FixturesEndpoint(leagueId: footballLeagueId, from: from, to: to),
            api: .football,
            model: AllSportsResponseDTO<FootballEventDTO>.self
        )
        XCTAssertFalse(events.result?.isEmpty ?? true)

        let latest: AllSportsResponseDTO<FootballEventDTO> =
        try await networkManager.request(
            endpoint: FixturesEndpoint(leagueId: footballLeagueId, from: from, to: to),
            api: .football,
            model: AllSportsResponseDTO<FootballEventDTO>.self
        )
        XCTAssertFalse(latest.result?.isEmpty ?? true)
    }

    func test_BasketballLeaguesEndpoint() async throws {
        let endpoint = LeaguesEndpoint()

        let response: AllSportsResponseDTO<BasketballLeagueDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .basketball,
            model: AllSportsResponseDTO<BasketballLeagueDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result?.isEmpty ?? true)

        let league = response.result!.first!
        XCTAssertFalse(league.leagueName.isEmpty)
    }

    func test_BasketballLeagueTeamsEndpoint() async throws {
        let endpoint = TeamsByLeagueEndpoint(leagueId: basketballLeagueId)

        let response: AllSportsResponseDTO<BasketballTeamDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .basketball,
            model: AllSportsResponseDTO<BasketballTeamDTO>.self
        )
        
        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result!.isEmpty)
        XCTAssertFalse(response.result!.first!.teamName.isEmpty)
    }

    func test_BasketballLeagueLatestResultsEndpoint() async throws {
        let endpoint = FixturesEndpoint(leagueId: basketballLeagueId, from: from, to: to)

        let response: AllSportsResponseDTO<BasketballEventDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .basketball,
            model: AllSportsResponseDTO<BasketballEventDTO>.self
        )

        XCTAssertNotNil(response.result)
        XCTAssertFalse(response.result!.isEmpty)

        XCTAssertNotNil(response.result!.first!.eventFinalResult)
    }

    func test_BasketballTeamByIdEndpoint() async throws {
        let endpoint = TeamByIdEndpoint(teamId: basketballTeamId)

        let response: AllSportsResponseDTO<BasketballTeamDTO> =
        try await networkManager.request(
            endpoint: endpoint,
            api: .basketball,
            model: AllSportsResponseDTO<BasketballTeamDTO>.self
        )

        XCTAssertFalse(response.result?.isEmpty ?? true)
        XCTAssertEqual(response.result!.first!.teamKey, basketballTeamId)
    }
}

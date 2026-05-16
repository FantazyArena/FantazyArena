//
//  FootballAPIServiceTests.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import XCTest
import Alamofire
@testable import fantazy

final class FootballAPIServiceTests: XCTestCase {


    private func makeService(jsonFile: String) -> FootballAPIService {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError(" Missing \(jsonFile).json — check it's added to fantazyTests target")
        }
        MockURLProtocol.mockData = data
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return FootballAPIService(session: Session(configuration: config))
    }

    override func tearDown() {
        MockURLProtocol.mockData = nil
        super.tearDown()
    }

    // getLeagues

    func test_getLeagues_returnsCorrectCount() async throws {
        let service = makeService(jsonFile: "FootballLeaguesResponse")
        let leagues = try await service.getLeagues()
        XCTAssertEqual(leagues.count, 2)
    }

    func test_getLeagues_returnsCorrectName() async throws {
        let service = makeService(jsonFile: "FootballLeaguesResponse")
        let leagues = try await service.getLeagues()
        XCTAssertEqual(leagues[0].name, "Premier League")
        XCTAssertEqual(leagues[1].name, "La Liga")
    }

    // getTeams

    func test_getTeams_returnsCorrectName() async throws {
        let service = makeService(jsonFile: "FootballTeamsResponse")
        let teams = try await service.getTeams(leagueId: 1)
        XCTAssertEqual(teams[0].name, "Arsenal")
    }

    func test_getTeams_returnsCorrectCount() async throws {
        let service = makeService(jsonFile: "FootballTeamsResponse")
        let teams = try await service.getTeams(leagueId: 1)
        XCTAssertEqual(teams.count, 1)
    }

    // getFixtures

    func test_getFixtures_returnsCorrectHomeTeam() async throws {
        let service = makeService(jsonFile: "FootballFixturesResponse")
        let events = try await service.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
        XCTAssertEqual(events[0].homeTeam.name, "Arsenal")
    }

    func test_getFixtures_returnsCorrectAwayTeam() async throws {
        let service = makeService(jsonFile: "FootballFixturesResponse")
        let events = try await service.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
        XCTAssertEqual(events[0].awayTeam.name, "Chelsea")
    }

    // getLatestResults

    func test_getLatestResults_returnsCorrectCount() async throws {
        let service = makeService(jsonFile: "FootballFixturesResponse")
        let results = try await service.getLatestResults(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
        XCTAssertFalse(results.isEmpty)
    }
}

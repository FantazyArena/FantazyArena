//
//  MockSportService.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import XCTest
@testable import fantazy

class MockSportService: SportService {
    

    var leaguesResult: Result<[League], Error> = .success([])
    var teamsResult: Result<[Team], Error> = .success([])
    var fixturesResult: Result<[Event], Error> = .success([])
    var latestResultsResult: Result<[LatestResult], Error> = .success([])


    var getLeaguesCalled = false
    var getTeamsCalledWithId: Int?

    func getLeagues() async throws -> [League] {
        getLeaguesCalled = true
        return try leaguesResult.get()
    }

    func getTeams(leagueId: Int) async throws -> [Team] {
        getTeamsCalledWithId = leagueId
        return try teamsResult.get()
    }

    func getFixtures(leagueId: Int, from: String, to: String) async throws -> [Event] {
        return try fixturesResult.get()
    }

    func getLatestResults(leagueId: Int, from: String, to: String) async throws -> [LatestResult] {
        return try latestResultsResult.get()
    }
}

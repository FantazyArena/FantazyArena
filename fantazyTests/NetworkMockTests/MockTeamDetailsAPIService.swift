//
//  MockTeamDetailsAPIService.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import XCTest
@testable import fantazy

class MockTeamDetailsAPIService: TeamDetailsAPIServiceProtocol {

    var footballResult: Result<FootballTeamDetailsDTO?, Error> = .success(nil)
    var basketballResult: Result<BasketballTeamDetailsDTO?, Error> = .success(nil)

    var footballCalledWithName: String?
    var basketballCalledWithName: String?

    func getFootballTeamDetails(name: String) async throws -> FootballTeamDetailsDTO? {
        footballCalledWithName = name
        return try footballResult.get()
    }

    func getBasketballTeamDetails(name: String) async throws -> BasketballTeamDetailsDTO? {
        basketballCalledWithName = name
        return try basketballResult.get()
    }
}

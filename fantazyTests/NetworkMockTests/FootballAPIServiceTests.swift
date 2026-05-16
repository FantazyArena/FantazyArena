//
//  FootballAPIServiceTests.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.


import XCTest
@testable import fantazy

final class FootballAPIServiceTests: XCTestCase {

    var mockService: MockSportService!

    // Fake Data

    let fakeLeagues = [
        League(id: "1", name: "Premier League", badgeURL: "", countryName: "England"),
        League(id: "2", name: "La Liga", badgeURL: "", countryName: "Spain")
    ]

    let fakeTeams = [
        Team(thumbnail: "", name: "Arsenal", coach: "Mikel Arteta", players: [
            Player(name: "Saka", number: "7", position: "Midfielders", image: "")
        ])
    ]

    let fakeEvents = [
        Event(
            id: "100",
            homeTeam: Team(thumbnail: "", name: "Arsenal", coach: "", players: []),
            awayTeam: Team(thumbnail: "", name: "Chelsea", coach: "", players: []),
            date: "2024-01-15",
            time: "20:00",
            stadium: "Emirates Stadium",
            league: "Premier League",
            status: .finished
        )
    ]

    let fakeLatestResults = [
        LatestResult(
            homeTeamLogo: "",
            awayTeamLogo: "",
            homeTeamName: "Arsenal",
            awayTeamName: "Chelsea",
            result: "2-1",
            date: "2024-01-15"
        )
    ]

    //Setup

    override func setUp() {
        super.setUp()
        mockService = MockSportService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    // getLeagues

    func test_getLeagues_returnsCorrectCount() {
        let expectation = XCTestExpectation(description: "getLeagues returns correct count")
        mockService.leaguesResult = .success(fakeLeagues)

        Task {
            do {
                let leagues = try await mockService.getLeagues()
                XCTAssertEqual(leagues.count, 2)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLeagues_returnsCorrectName() {
        let expectation = XCTestExpectation(description: "getLeagues returns correct name")
        mockService.leaguesResult = .success(fakeLeagues)

        Task {
            do {
                let leagues = try await mockService.getLeagues()
                XCTAssertEqual(leagues[0].name, "Premier League")
                XCTAssertEqual(leagues[1].name, "La Liga")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLeagues_returnsCorrectCountry() {
        let expectation = XCTestExpectation(description: "getLeagues returns correct country")
        mockService.leaguesResult = .success(fakeLeagues)

        Task {
            do {
                let leagues = try await mockService.getLeagues()
                XCTAssertEqual(leagues[0].countryName, "England")
                XCTAssertEqual(leagues[1].countryName, "Spain")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLeagues_failure_throwsError() {
        let expectation = XCTestExpectation(description: "getLeagues throws error")
        mockService.leaguesResult = .failure(
            NSError(domain: "TestError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server Error"])
        )

        Task {
            do {
                _ = try await mockService.getLeagues()
                XCTFail("Should have thrown")
            } catch {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    // getTeams

    func test_getTeams_returnsCorrectCount() {
        let expectation = XCTestExpectation(description: "getTeams returns correct count")
        mockService.teamsResult = .success(fakeTeams)

        Task {
            do {
                let teams = try await mockService.getTeams(leagueId: 1)
                XCTAssertEqual(teams.count, 1)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getTeams_returnsCorrectName() {
        let expectation = XCTestExpectation(description: "getTeams returns correct name")
        mockService.teamsResult = .success(fakeTeams)

        Task {
            do {
                let teams = try await mockService.getTeams(leagueId: 1)
                XCTAssertEqual(teams[0].name, "Arsenal")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getTeams_returnsCorrectCoach() {
        let expectation = XCTestExpectation(description: "getTeams returns correct coach")
        mockService.teamsResult = .success(fakeTeams)

        Task {
            do {
                let teams = try await mockService.getTeams(leagueId: 1)
                XCTAssertEqual(teams[0].coach, "Mikel Arteta")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getTeams_calledWithCorrectLeagueId() {
        let expectation = XCTestExpectation(description: "getTeams called with correct leagueId")
        mockService.teamsResult = .success(fakeTeams)

        Task {
            do {
                _ = try await mockService.getTeams(leagueId: 99)
                XCTAssertEqual(mockService.getTeamsCalledWithId, 99)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getTeams_failure_throwsError() {
        let expectation = XCTestExpectation(description: "getTeams throws error")
        mockService.teamsResult = .failure(
            NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not Found"])
        )

        Task {
            do {
                _ = try await mockService.getTeams(leagueId: 1)
                XCTFail("Should have thrown")
            } catch {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    // getFixtures

    func test_getFixtures_returnsCorrectCount() {
        let expectation = XCTestExpectation(description: "getFixtures returns correct count")
        mockService.fixturesResult = .success(fakeEvents)

        Task {
            do {
                let events = try await mockService.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(events.count, 1)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getFixtures_returnsCorrectHomeTeam() {
        let expectation = XCTestExpectation(description: "getFixtures returns correct home team")
        mockService.fixturesResult = .success(fakeEvents)

        Task {
            do {
                let events = try await mockService.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(events[0].homeTeam.name, "Arsenal")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getFixtures_returnsCorrectAwayTeam() {
        let expectation = XCTestExpectation(description: "getFixtures returns correct away team")
        mockService.fixturesResult = .success(fakeEvents)

        Task {
            do {
                let events = try await mockService.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(events[0].awayTeam.name, "Chelsea")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getFixtures_returnsCorrectStatus() {
        let expectation = XCTestExpectation(description: "getFixtures returns correct status")
        mockService.fixturesResult = .success(fakeEvents)

        Task {
            do {
                let events = try await mockService.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(events[0].status, .finished)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getFixtures_failure_throwsError() {
        let expectation = XCTestExpectation(description: "getFixtures throws error")
        mockService.fixturesResult = .failure(
            NSError(domain: "TestError", code: 500)
        )

        Task {
            do {
                _ = try await mockService.getFixtures(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTFail("Should have thrown")
            } catch {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    // getLatestResults

    func test_getLatestResults_returnsCorrectCount() {
        let expectation = XCTestExpectation(description: "getLatestResults returns correct count")
        mockService.latestResultsResult = .success(fakeLatestResults)

        Task {
            do {
                let results = try await mockService.getLatestResults(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(results.count, 1)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLatestResults_returnsCorrectHomeTeamName() {
        let expectation = XCTestExpectation(description: "getLatestResults returns correct home team name")
        mockService.latestResultsResult = .success(fakeLatestResults)

        Task {
            do {
                let results = try await mockService.getLatestResults(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(results[0].homeTeamName, "Arsenal")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLatestResults_returnsCorrectResult() {
        let expectation = XCTestExpectation(description: "getLatestResults returns correct result")
        mockService.latestResultsResult = .success(fakeLatestResults)

        Task {
            do {
                let results = try await mockService.getLatestResults(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTAssertEqual(results[0].result, "2-1")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getLatestResults_failure_throwsError() {
        let expectation = XCTestExpectation(description: "getLatestResults throws error")
        mockService.latestResultsResult = .failure(
            NSError(domain: "TestError", code: 500)
        )

        Task {
            do {
                _ = try await mockService.getLatestResults(leagueId: 1, from: "2024-01-01", to: "2024-01-31")
                XCTFail("Should have thrown")
            } catch {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

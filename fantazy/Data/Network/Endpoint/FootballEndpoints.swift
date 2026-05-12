// FootballEndpoints.swift
// All endpoint definitions for the Football allsportsapi.com API.

import Alamofire

// MARK: - Get All Leagues
// GET ?met=Leagues&APIkey=

struct FootballLeaguesEndpoint: Endpoint {
    var path: String { "" }
    var parameters: Parameters {
        [
            "met": "Leagues",
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

// MARK: - Get Teams by League ID
// GET ?met=Teams&leagueId={id}&APIkey=

struct FootballTeamsByLeagueEndpoint: Endpoint {
    let leagueId: Int

    var path: String { "" }
    var parameters: Parameters {
        [
            "met": "Teams",
            "leagueId": leagueId,
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

// MARK: - Get Teams by Name (Search)
// GET ?met=Teams&teamName={name}&APIkey=

struct FootballTeamsByNameEndpoint: Endpoint {
    let teamName: String

    var path: String { "" }
    var parameters: Parameters {
        [
            "met": "Teams",
            "teamName": teamName,
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

// MARK: - Get Fixtures (Upcoming & Results)
// Reused for both upcoming and past fixtures; caller controls the date range.
// GET ?met=Fixtures&from={from}&to={to}&leagueId={id}&APIkey=

struct FootballFixturesEndpoint: Endpoint {
    let leagueId: Int
    let from: String    // "YYYY-MM-DD"
    let to: String      // "YYYY-MM-DD"

    var path: String { "" }
    var parameters: Parameters {
        [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": from,
            "to": to,
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

// MARK: - Get Additional Team Details (api-sports.io)
// Uses a DIFFERENT base URL and auth via HTTP header, not query param.
// GET {FOOTBALL_TEAM_BASE_URL}?name={name}
// Header: x-apisports-key: <TEAM_API_KEY>

struct FootballTeamDetailsEndpoint: Endpoint {
    let teamName: String

    var path: String { "" }
    var parameters: Parameters { ["name": teamName] }
    var headers: HTTPHeaders {
        HTTPHeaders(["x-apisports-key": ApiConfig.TEAM_API_KEY])
    }
}

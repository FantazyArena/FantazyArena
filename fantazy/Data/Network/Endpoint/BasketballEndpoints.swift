// BasketballEndpoints.swift
// All endpoint definitions for the Basketball allsportsapi.com API.

import Alamofire

// MARK: - Get All Leagues
// GET ?met=Leagues&APIkey=

struct BasketballLeaguesEndpoint: Endpoint {
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

struct BasketballTeamsByLeagueEndpoint: Endpoint {
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

// MARK: - Get Team by ID
// GET ?met=Teams&teamId={id}&APIkey=
// NOTE: Basketball uses teamId (Int), football uses teamName (String) for team lookup.

struct BasketballTeamByIdEndpoint: Endpoint {
    let teamId: Int

    var path: String { "" }
    var parameters: Parameters {
        [
            "met": "Teams",
            "teamId": teamId,
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

// MARK: - Get Fixtures (Upcoming & Results)
// GET ?met=Fixtures&from={from}&to={to}&leagueId={id}&APIkey=

struct BasketballFixturesEndpoint: Endpoint {
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
// Uses a DIFFERENT base URL and auth via HTTP header.
// GET {BASKETBALL_TEAM_BASE_URL}?name={name}
// Header: x-apisports-key: <TEAM_API_KEY>

struct BasketballTeamDetailsEndpoint: Endpoint {
    let teamName: String

    var path: String { "" }
    var parameters: Parameters { ["name": teamName] }
    var headers: HTTPHeaders {
        HTTPHeaders(["x-apisports-key": ApiConfig.TEAM_API_KEY])
    }
}

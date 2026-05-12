import Alamofire

protocol Endpoint {
    var path: String { get }
    var parameters: Parameters { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    var headers: HTTPHeaders { HTTPHeaders() }
    var path: String { "" }
}

struct LeaguesEndpoint: Endpoint {
    var parameters: Parameters {
        ["met": "Leagues", "APIkey": ApiConfig.SPORTS_API_KEY]
    }
}

struct TeamsByLeagueEndpoint: Endpoint {
    let leagueId: Int
    var parameters: Parameters {
        ["met": "Teams", "leagueId": leagueId, "APIkey": ApiConfig.SPORTS_API_KEY]
    }
}

struct FixturesEndpoint: Endpoint {
    let leagueId: Int
    let from: String
    let to: String
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


struct TeamsByNameEndpoint: Endpoint {
    let teamName: String
    var parameters: Parameters {
        ["met": "Teams", "teamName": teamName, "APIkey": ApiConfig.SPORTS_API_KEY]
    }
}


struct TeamByIdEndpoint: Endpoint {
    let teamId: Int
    var parameters: Parameters {
        ["met": "Teams", "teamId": teamId, "APIkey": ApiConfig.SPORTS_API_KEY]
    }
}


struct TeamDetailsEndpoint: Endpoint {
    let teamName: String
    var parameters: Parameters { ["name": teamName] }
    var headers: HTTPHeaders {
        HTTPHeaders(["x-apisports-key": ApiConfig.TEAM_API_KEY])
    }
}

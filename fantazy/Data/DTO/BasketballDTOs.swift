import Foundation

struct BasketballLeagueDTO: Decodable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case countryKey  = "country_key"
        case countryName = "country_name"
    }
}

struct BasketballTeamDTO: Decodable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?

    enum CodingKeys: String, CodingKey {
        case teamKey  = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}

struct BasketballEventDTO: Decodable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventFinalResult: String?
    let eventQuarter: String?
    let eventStatus: String?
    let eventLive: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueSeason: String?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey           = "event_key"
        case eventDate          = "event_date"
        case eventTime          = "event_time"
        case eventHomeTeam      = "event_home_team"
        case homeTeamKey        = "home_team_key"
        case eventAwayTeam      = "event_away_team"
        case awayTeamKey        = "away_team_key"
        case eventFinalResult   = "event_final_result"
        case eventQuarter       = "event_quarter"
        case eventStatus        = "event_status"
        case eventLive          = "event_live"
        case countryName        = "country_name"
        case leagueName         = "league_name"
        case leagueKey          = "league_key"
        case leagueSeason       = "league_season"
        case eventHomeTeamLogo  = "event_home_team_logo"
        case eventAwayTeamLogo  = "event_away_team_logo"
    }
}

struct BasketballTeamDetailsDTO: Decodable {
    let id: Int
    let name: String
    let logo: String?
    let nationnal: Bool?
    let country: BasketballTeamCountryDTO?
}

struct BasketballTeamCountryDTO: Decodable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

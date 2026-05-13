import Foundation

struct FootballLeagueDTO: Decodable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}

struct FootballTeamDTO: Decodable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let national: String?
    let players: [FootballPlayerDTO]?
    let coaches: [FootballCoachDTO]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case national = "team_national"
        case coaches = "coaches"
        case players
    }
}

struct FootballCoachDTO: Decodable{
    let coachName: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}

struct FootballPlayerDTO: Decodable {
    let playerKey: Int?
    let playerName: String?
    let playerNumber: String?
    let playerType: String?
    let playerImage: String?
    let playerAge: String?

    enum CodingKeys: String, CodingKey {
        case playerKey    = "player_key"
        case playerName   = "player_name"
        case playerNumber = "player_number"
        case playerType   = "player_type"
        case playerImage  = "player_image"
        case playerAge    = "player_age"
    }
}


struct FootballEventDTO: Decodable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventFinalResult: String?
    let eventHalftimeResult: String?
    let eventStatus: String?
    let eventLive: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueSeason: String?
    let eventStadium: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventHalftimeResult = "event_halftime_result"
        case eventStatus = "event_status"
        case eventLive = "event_live"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueSeason = "league_season"
        case eventStadium = "event_stadium"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
    }
}

struct FootballTeamDetailsDTO: Decodable {
    let team: FootballTeamInfoDTO
    let venue: FootballVenueDTO?
}

struct FootballTeamInfoDTO: Decodable {
    let id: Int
    let name: String
    let code: String?
    let country: String?
    let founded: Int?
    let logo: String?
}

struct FootballVenueDTO: Decodable {
    let id: Int?
    let name: String?
    let city: String?
    let capacity: Int?
    let image: String?
}

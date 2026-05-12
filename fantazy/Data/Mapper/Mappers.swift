import Foundation


struct FootballMapper {

    static func toLeague(_ dto: FootballLeagueDTO) -> League {
        League(
            name: dto.leagueName,
            badgeURL: dto.leagueLogo ?? "",
            countryName: dto.countryName ?? ""
        )
    }

    static func toTeam(_ dto: FootballTeamDTO) -> Team {
        return Team(
            thumbnail: dto.teamLogo ?? "",
            name: dto.teamName
        )
    }

    static func toPlayer(_ dto: FootballPlayerDTO) -> Player {
        Player(
            name: dto.playerName ?? "",
            number: dto.playerNumber ?? "",
            position: dto.playerType ?? "",
            image: dto.playerImage ?? ""
        )
    }

    static func toEvent(_ dto: FootballEventDTO) -> Event {
        let homeTeam = Team(
            thumbnail: dto.homeTeamLogo ?? "",
            name: dto.eventHomeTeam ?? ""
        )
        let awayTeam = Team(
            thumbnail: dto.awayTeamLogo ?? "",
            name: dto.eventAwayTeam ?? ""
        )
        return Event(
            id: String(dto.eventKey),
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            date: dto.eventDate ?? "",
            time: dto.eventTime ?? "",
            stadium: dto.eventStadium,
            league: dto.leagueName,
            status: mapStatus(live: dto.eventLive, status: dto.eventStatus)
        )
    }

    private static func mapStatus(live: String?, status: String?) -> EventStatus {
        if live == "1" { return .live }
        if status?.lowercased() == "finished" { return .finished }
        return .upcoming
    }
}

struct BasketballMapper {

    static func toLeague(_ dto: BasketballLeagueDTO) -> League {
        League(
            name: dto.leagueName,
            badgeURL: "",
            countryName: dto.countryName ?? ""
        )
    }

    static func toTeam(_ dto: BasketballTeamDTO) -> Team {
        Team(
            thumbnail: dto.teamLogo ?? "",
            name: dto.teamName
        )
    }

    static func toEvent(_ dto: BasketballEventDTO) -> Event {
        let homeTeam = Team(
            thumbnail: dto.eventHomeTeamLogo ?? "",
            name: dto.eventHomeTeam ?? ""
        )
        let awayTeam = Team(
            thumbnail: dto.eventAwayTeamLogo ?? "",
            name: dto.eventAwayTeam ?? ""
        )
        return Event(
            id: String(dto.eventKey),
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            date: dto.eventDate ?? "",
            time: dto.eventTime ?? "",
            stadium: nil,
            league: dto.leagueName,
            status: mapStatus(live: dto.eventLive, status: dto.eventStatus)
        )
    }

    private static func mapStatus(live: String?, status: String?) -> EventStatus {
        if live == "1" { return .live }
        if let s = status, !s.isEmpty, s != "0" { return .finished }
        return .upcoming
    }
}

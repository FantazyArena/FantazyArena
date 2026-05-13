import Foundation


struct FootballMapper {

    static func toLeague(_ dto: FootballLeagueDTO) -> League {
        League(
            id: String(dto.leagueKey),
            name: dto.leagueName,
            badgeURL: dto.leagueLogo ?? "",
            countryName: dto.countryName ?? ""
        )
    }
    
    static func toLatestResult(_ dto: FootballEventDTO) -> LatestResult {
            let homeTeam = Team(
                thumbnail: dto.homeTeamLogo ?? "",
                name: dto.eventHomeTeam ?? "",
                coach: "",
                players: []
            )
            let awayTeam = Team(
                thumbnail: dto.awayTeamLogo ?? "",
                name: dto.eventAwayTeam ?? "",
                coach: "",
                players: []
            )
            
            return LatestResult(
                homeTeamLogo: homeTeam.thumbnail ?? "",
                awayTeamLogo: awayTeam.thumbnail ?? "",
                homeTeamName: homeTeam.name,
                awayTeamName: awayTeam.name,
                result: dto.eventFinalResult ?? "0 - 0",
                date: dto.eventDate ?? ""
            )
        }

    static func toTeam(_ dto: FootballTeamDTO) -> Team {
        return Team(
            thumbnail: dto.teamLogo ?? "",
            name: dto.teamName,
            coach: dto.coaches?[0].coachName ?? "",
            players: dto.players?.map(FootballMapper.toPlayer) ?? []
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
            name: dto.eventHomeTeam ?? "",
            coach: "",
            players: []
        )
        let awayTeam = Team(
            thumbnail: dto.awayTeamLogo ?? "",
            name: dto.eventAwayTeam ?? "",
            coach: "",
            players: []
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
            id: String(dto.leagueKey),
            name: dto.leagueName,
            badgeURL: "",
            countryName: dto.countryName ?? ""
        )
    }
    
    static func toLatestResult(_ dto: BasketballEventDTO) -> LatestResult {
            let homeTeam = Team(
                thumbnail: dto.eventHomeTeamLogo ?? "",
                name: dto.eventHomeTeam ?? "",
                coach: "",
                players: []
            )
            let awayTeam = Team(
                thumbnail: dto.eventAwayTeamLogo ?? "",
                name: dto.eventAwayTeam ?? "",
                coach: "",
                players: []
            )

            return LatestResult(
                homeTeamLogo: homeTeam.thumbnail ?? "",
                awayTeamLogo: awayTeam.thumbnail ?? "",
                homeTeamName: homeTeam.name,
                awayTeamName: awayTeam.name,
                result: dto.eventFinalResult ?? "0 - 0",
                date: dto.eventDate ?? ""
            )
        }

    static func toTeam(_ dto: BasketballTeamDTO) -> Team {
        Team(
            thumbnail: dto.teamLogo ?? "",
            name: dto.teamName,
            coach: "",
            players: []
        )
    }

    static func toEvent(_ dto: BasketballEventDTO) -> Event {
        let homeTeam = Team(
            thumbnail: dto.eventHomeTeamLogo ?? "",
            name: dto.eventHomeTeam ?? "",
            coach: "",
            players: []
        )
        let awayTeam = Team(
            thumbnail: dto.eventAwayTeamLogo ?? "",
            name: dto.eventAwayTeam ?? "",
            coach: "",
            players: []
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

struct FootballTeamDetailsMapper{
    static func toTeam(_ dto: FootballTeamDetailsDTO) -> TeamDetails {
        TeamDetails(
            thumbnail: dto.team.logo ?? "",
            name: dto.team.name,
            founded: String(dto.team.founded ?? 0),
            national: dto.team.country ?? "",
            players: []
        )
    }
}

struct BasketballTeamDetailsMapper{
    static func toTeam(_ dto: BasketballTeamDetailsDTO) -> TeamDetails {
        TeamDetails(
            thumbnail: dto.logo ?? "",
            name: dto.name,
            founded: "2020",
            national: dto.country?.name ?? "",
            players: []
        )
    }
}

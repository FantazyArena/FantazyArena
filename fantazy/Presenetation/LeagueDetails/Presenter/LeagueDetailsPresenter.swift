//
//  LeagueDetailsPresenterProtocol.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    weak var view: LeagueDetailsViewProtocol?

    let teams: [Team] = [

        // 1. FC Barcelona
        Team(
            thumbnail: "barcelona_logo.jpg",
            name: "Barcelona",
            coach: "Ahmed",
            players: [
                Player(name: "Player", number: "10", position: "Attacker", image: "")
            ]
        ),
        Team(
            thumbnail: "barcelona_logo.jpg",
            name: "Barcelona",
            coach: "Ahmed",
            players: [
                Player(name: "Player", number: "10", position: "Attacker", image: "")
            ]
        ),
        Team(
            thumbnail: "barcelona_logo.jpg",
            name: "Barcelona",
            coach: "Ahmed",
            players: [
                Player(name: "Player", number: "10", position: "Attacker", image: "")
            ]
        ),
        Team(
            thumbnail: "barcelona_logo.jpg",
            name: "Barcelona",
            coach: "Ahmed",
            players: [
                Player(name: "Player", number: "10", position: "Attacker", image: "")
            ]
        ),
    ]

    private lazy var events: [Event] = [
        Event(id: "1",
              homeTeam: teams[0],
              awayTeam: teams[1],
              date: "12 May 2026",
              time: "20:45",
              stadium: "Camp Nou",
              league: "Champions League",
              status: .upcoming),
        Event(id: "2",
              homeTeam: teams[2],
              awayTeam: teams[3],
              date: "13 May 2026",
              time: "18:00",
              stadium: "Emirates Stadium",
              league: "Champions League",
              status: .live),
        Event(id: "3",
              homeTeam: teams[1],
              awayTeam: teams[3],
              date: "15 May 2026",
              time: "21:00",
              stadium: "Anfield",
              league: "Champions League",
              status: .upcoming)
    ]
    
    private let leagueId: String

    init(leagueId: String) {
        self.leagueId = leagueId
    }

    private lazy var latestResults: [LatestResult] = [
        LatestResult(
            homeTeamLogo: "teamA_logo",
            awayTeamLogo: "teamB_logo",
            homeTeamName: "Team A",
            awayTeamName: "Team B",
            result: "2 - 1",
            date: "2024-05-10"
        ),
        LatestResult(
            homeTeamLogo: "teamC_logo",
            awayTeamLogo: "teamD_logo",
            homeTeamName: "Team C",
            awayTeamName: "Team D",
            result: "0 - 0",
            date: "2024-05-09"
        ),
        LatestResult(
            homeTeamLogo: "teamE_logo",
            awayTeamLogo: "teamF_logo",
            homeTeamName: "Team E",
            awayTeamName: "Team F",
            result: "1 - 3",
            date: "2024-05-08"
        ),
        LatestResult(
            homeTeamLogo: "teamG_logo",
            awayTeamLogo: "teamH_logo",
            homeTeamName: "Team G",
            awayTeamName: "Team H",
            result: "4 - 2",
            date: "2024-05-07"
        ),
        LatestResult(
            homeTeamLogo: "teamI_logo",
            awayTeamLogo: "teamJ_logo",
            homeTeamName: "Team I",
            awayTeamName: "Team J",
            result: "1 - 1",
            date: "2024-05-06"
        )
    ]
    
    private let league: League = League(id: "id", name: "English Premier League", badgeURL: "", countryName: "England")
    
    func viewDidLoad() {
        view?.loadLeagueDetails(league: league)
        view?.reloadTeams()
        view?.reloadEvents()
    }

    func toggleFavorite() {}

    func numberOfTeams() -> Int { return teams.count }
    func numberOfEvents() -> Int { return events.count }
    func numberOfLatestResults() -> Int { return latestResults.count }
    
    func getTeam(at index: Int) -> Team { return teams[index] }
    func getEvent(at index: Int) -> Event { return events[index] }
    func getLatestResult(at index: Int) -> LatestResult { return latestResults[index] }
}

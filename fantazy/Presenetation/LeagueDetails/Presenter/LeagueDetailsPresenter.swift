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
            name: "FC Barcelona"
        ),

        // 2. Real Madrid
        Team(
            thumbnail: "realmadrid_logo.jpg",
            name: "Real Madrid"
        ),

        // 3. Manchester City
        Team(
            thumbnail: "man_city_logo.jpg",
            name: "Manchester City"
        ),

        // 4. Manchester United
        Team(
            thumbnail: "man_united_logo.jpg",
            name: "Manchester United"
        ),

        // 5. Liverpool
        Team(
            thumbnail: "liverpool_logo.jpg",
            name: "Liverpool"
        ),

        // 6. Arsenal
        Team(
            thumbnail: "arsenal_logo.jpg",
            name: "Arsenal"
        ),

        // 7. Chelsea
        Team(
            thumbnail: "chelsea_logo.jpg",
            name: "Chelsea"
        ),

        // 8. Paris Saint-Germain (PSG)
        Team(
            thumbnail: "psg_logo.jpg",
            name: "Paris Saint-Germain"
        ),

        // 9. Bayern Munich
        Team(
            thumbnail: "bayern_logo.jpg",
            name: "Bayern Munich"
        ),

        // 10. Juventus
        Team(
            thumbnail: "juventus_logo.jpg",
            name: "Juventus"
        ),

        // 11. Inter Milan
        Team(
            thumbnail: "inter_logo.jpg",
            name: "Inter Milan"
        ),

        // 12. AC Milan
        Team(
            thumbnail: "acmilan_logo.jpg",
            name: "AC Milan"
        )
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

    func viewDidLoad() {
        view?.reloadTeams()
        view?.reloadEvents()
    }

    func toggleFavorite() {}

    func numberOfTeams() -> Int { return teams.count }
    func numberOfEvents() -> Int { return events.count }
    func getTeam(at index: Int) -> Team { return teams[index] }
    func getEvent(at index: Int) -> Event { return events[index] }
}

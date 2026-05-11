//
//  LeagueDetailsPresenterProtocol.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    weak var view: LeagueDetailsViewProtocol?

    private var teams: [Team] = [
        Team(id: "1", name: "Barcelona", badgeURL: "https://www.imageinsight.com/wp-content/uploads/2022/03/LFC-scaled.jpg", posterURL: nil,
             foundedYear: "1899", stadiumName: "Camp Nou",
             description: "Spanish football club",
             socialLinks: SocialLinks(website: nil, twitter: nil, instagram: nil, youtube: nil),
             members: []),
        Team(id: "2", name: "Liverpool", badgeURL: nil, posterURL: nil,
             foundedYear: "1892", stadiumName: "Anfield",
             description: "English football club",
             socialLinks: SocialLinks(website: nil, twitter: nil, instagram: nil, youtube: nil),
             members: []),
        Team(id: "3", name: "Arsenal", badgeURL: nil, posterURL: nil,
             foundedYear: "1886", stadiumName: "Emirates Stadium",
             description: "English football club",
             socialLinks: SocialLinks(website: nil, twitter: nil, instagram: nil, youtube: nil),
             members: []),
        Team(id: "4", name: "Real Madrid", badgeURL: nil, posterURL: nil,
             foundedYear: "1902", stadiumName: "Bernabeu",
             description: "Spanish football club",
             socialLinks: SocialLinks(website: nil, twitter: nil, instagram: nil, youtube: nil),
             members: [])
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

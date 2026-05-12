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
            name: "FC Barcelona",
            founded: "1899",
            stadium: "Camp Nou",
            coach: "Xavi Hernández",
            players: [
                Player(name: "Lionel Messi", number: "10", position: "Forward", image: "messi.jpg"),
                Player(name: "Pedri", number: "8", position: "Midfielder", image: "pedri.jpg"),
                Player(name: "Ronald Araújo", number: "4", position: "Defender", image: "araujo.jpg"),
                Player(name: "Ter Stegen", number: "1", position: "Goalkeeper", image: "terstegen.jpg")
            ]
        ),

        // 2. Real Madrid
        Team(
            thumbnail: "realmadrid_logo.jpg",
            name: "Real Madrid",
            founded: "1902",
            stadium: "Santiago Bernabéu",
            coach: "Carlo Ancelotti",
            players: [
                Player(name: "Karim Benzema", number: "9", position: "Forward", image: "benzema.jpg"),
                Player(name: "Luka Modrić", number: "10", position: "Midfielder", image: "modric.jpg"),
                Player(name: "David Alaba", number: "4", position: "Defender", image: "alaba.jpg"),
                Player(name: "Thibaut Courtois", number: "1", position: "Goalkeeper", image: "courtois.jpg")
            ]
        ),

        // 3. Manchester City
        Team(
            thumbnail: "man_city_logo.jpg",
            name: "Manchester City",
            founded: "1880",
            stadium: "Etihad Stadium",
            coach: "Pep Guardiola",
            players: [
                Player(name: "Erling Haaland", number: "9", position: "Forward", image: "haaland.jpg"),
                Player(name: "Kevin De Bruyne", number: "17", position: "Midfielder", image: "kdb.jpg"),
                Player(name: "Rúben Dias", number: "3", position: "Defender", image: "dias.jpg"),
                Player(name: "Ederson", number: "31", position: "Goalkeeper", image: "ederson.jpg")
            ]
        ),

        // 4. Manchester United
        Team(
            thumbnail: "man_united_logo.jpg",
            name: "Manchester United",
            founded: "1878",
            stadium: "Old Trafford",
            coach: "Erik ten Hag",
            players: [
                Player(name: "Marcus Rashford", number: "10", position: "Forward", image: "rashford.jpg"),
                Player(name: "Bruno Fernandes", number: "8", position: "Midfielder", image: "bruno.jpg"),
                Player(name: "Raphaël Varane", number: "19", position: "Defender", image: "varane.jpg"),
                Player(name: "David De Gea", number: "1", position: "Goalkeeper", image: "degea.jpg")
            ]
        ),

        // 5. Liverpool
        Team(
            thumbnail: "liverpool_logo.jpg",
            name: "Liverpool",
            founded: "1892",
            stadium: "Anfield",
            coach: "Jürgen Klopp",
            players: [
                Player(name: "Mohamed Salah", number: "11", position: "Forward", image: "salah.jpg"),
                Player(name: "Trent Alexander-Arnold", number: "66", position: "Defender", image: "taa.jpg"),
                Player(name: "Virgil van Dijk", number: "4", position: "Defender", image: "vandijk.jpg"),
                Player(name: "Alisson Becker", number: "1", position: "Goalkeeper", image: "alisson.jpg")
            ]
        ),

        // 6. Arsenal
        Team(
            thumbnail: "arsenal_logo.jpg",
            name: "Arsenal",
            founded: "1886",
            stadium: "Emirates Stadium",
            coach: "Mikel Arteta",
            players: [
                Player(name: "Bukayo Saka", number: "7", position: "Forward", image: "saka.jpg"),
                Player(name: "Martin Ødegaard", number: "8", position: "Midfielder", image: "odegaard.jpg"),
                Player(name: "Gabriel Magalhães", number: "6", position: "Defender", image: "gabriel.jpg"),
                Player(name: "Aaron Ramsdale", number: "1", position: "Goalkeeper", image: "ramsdale.jpg")
            ]
        ),

        // 7. Chelsea
        Team(
            thumbnail: "chelsea_logo.jpg",
            name: "Chelsea",
            founded: "1905",
            stadium: "Stamford Bridge",
            coach: "Mauricio Pochettino",
            players: [
                Player(name: "Raheem Sterling", number: "17", position: "Forward", image: "sterling.jpg"),
                Player(name: "Enzo Fernández", number: "8", position: "Midfielder", image: "enzo.jpg"),
                Player(name: "Thiago Silva", number: "6", position: "Defender", image: "silva.jpg"),
                Player(name: "Kepa Arrizabalaga", number: "1", position: "Goalkeeper", image: "kepa.jpg")
            ]
        ),

        // 8. Paris Saint-Germain (PSG)
        Team(
            thumbnail: "psg_logo.jpg",
            name: "Paris Saint-Germain",
            founded: "1970",
            stadium: "Parc des Princes",
            coach: "Luis Enrique",
            players: [
                Player(name: "Kylian Mbappé", number: "7", position: "Forward", image: "mbappe.jpg"),
                Player(name: "Neymar Jr", number: "10", position: "Forward", image: "neymar.jpg"),
                Player(name: "Marquinhos", number: "5", position: "Defender", image: "marquinhos.jpg"),
                Player(name: "Gianluigi Donnarumma", number: "99", position: "Goalkeeper", image: "donnarumma.jpg")
            ]
        ),

        // 9. Bayern Munich
        Team(
            thumbnail: "bayern_logo.jpg",
            name: "Bayern Munich",
            founded: "1900",
            stadium: "Allianz Arena",
            coach: "Thomas Tuchel",
            players: [
                Player(name: "Harry Kane", number: "9", position: "Forward", image: "kane.jpg"),
                Player(name: "Joshua Kimmich", number: "6", position: "Midfielder", image: "kimmich.jpg"),
                Player(name: "Matthijs de Ligt", number: "4", position: "Defender", image: "deligt.jpg"),
                Player(name: "Manuel Neuer", number: "1", position: "Goalkeeper", image: "neuer.jpg")
            ]
        ),

        // 10. Juventus
        Team(
            thumbnail: "juventus_logo.jpg",
            name: "Juventus",
            founded: "1897",
            stadium: "Allianz Stadium",
            coach: "Massimiliano Allegri",
            players: [
                Player(name: "Dušan Vlahović", number: "9", position: "Forward", image: "vlahovic.jpg"),
                Player(name: "Paul Pogba", number: "10", position: "Midfielder", image: "pogba.jpg"),
                Player(name: "Leonardo Bonucci", number: "19", position: "Defender", image: "bonucci.jpg"),
                Player(name: "Wojciech Szczęsny", number: "1", position: "Goalkeeper", image: "szczesny.jpg")
            ]
        ),

        // 11. Inter Milan
        Team(
            thumbnail: "inter_logo.jpg",
            name: "Inter Milan",
            founded: "1908",
            stadium: "San Siro",
            coach: "Simone Inzaghi",
            players: [
                Player(name: "Lautaro Martínez", number: "10", position: "Forward", image: "lautaro.jpg"),
                Player(name: "Nicolò Barella", number: "23", position: "Midfielder", image: "barella.jpg"),
                Player(name: "Stefan de Vrij", number: "6", position: "Defender", image: "devrij.jpg"),
                Player(name: "André Onana", number: "24", position: "Goalkeeper", image: "onana.jpg")
            ]
        ),

        // 12. AC Milan
        Team(
            thumbnail: "acmilan_logo.jpg",
            name: "AC Milan",
            founded: "1899",
            stadium: "San Siro",
            coach: "Stefano Pioli",
            players: [
                Player(name: "Rafael Leão", number: "17", position: "Forward", image: "leao.jpg"),
                Player(name: "Theo Hernández", number: "19", position: "Defender", image: "theo.jpg"),
                Player(name: "Ismaël Bennacer", number: "4", position: "Midfielder", image: "bennacer.jpg"),
                Player(name: "Mike Maignan", number: "16", position: "Goalkeeper", image: "maignan.jpg")
            ]
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
    
    private let league: League

    init(league: League) {
        self.league = league
    }

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

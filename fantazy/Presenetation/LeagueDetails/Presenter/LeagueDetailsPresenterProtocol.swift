//
//  LeagueDetailsPresenterProtocol.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import Foundation

protocol LeagueDetailsViewProtocol: AnyObject {
    func reloadTeams()
    func reloadEvents()
    func updateFavoriteState(isFavorite: Bool)
    func loadLeagueDetails(league: League)
}

protocol LeagueDetailsPresenterProtocol: AnyObject {
    var view: LeagueDetailsViewProtocol? { get set }
    func viewDidLoad()
    func toggleFavorite()
    func numberOfTeams() -> Int
    func numberOfEvents() -> Int
    func numberOfLatestResults() -> Int
    func getTeam(at index: Int) -> Team
    func getEvent(at index: Int) -> Event
    func getLatestResult(at index: Int) -> LatestResult
}

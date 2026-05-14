//
//  LeagueDetailsPresenterProtocol.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    
    weak var view: LeagueDetailsViewProtocol?
    
    private var teams: [Team] = []
    private var events: [Event] = []
    private var latestResults: [LatestResult] = []

    private var currentLeague: League?
    private let leagueId: String
    private let sportType:SportType
    
    init(leagueId: String,sportType:SportType,currentLeague:League) {
        self.leagueId = leagueId
        self.sportType = sportType
        self.currentLeague = currentLeague
    }

    func viewDidLoad() {
        
        view?.updateFavoriteState(isFavorite: isFavorite())
    }
    
    func loadLeagueDetails() {
        
        Task {
            await MainActor.run { view?.showLoading() }

            do {
                 let idInt = Int(leagueId)

                let details = try await SportsRepository.shared.getLeagueDetails(for: sportType, leagueId: idInt!)
                
                self.teams = details.teams
                self.latestResults = details.latest
                self.events = details.upcoming
                
                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.reloadLeagueDetails()
                    self.view?.reloadTeams()
                    self.view?.reloadEvents()
                }
            } catch {
                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    func isFavorite() -> Bool {
        return SportsRepository.shared.isLeagueFavorite(id: leagueId)
    }
    
    func toggleFavorite() {
        if isFavorite() {
            view?.updateFavoriteState(isFavorite: false)
        } else  {
            SportsRepository.shared.addLeagueToFavorite(league: currentLeague!)
            view?.updateFavoriteState(isFavorite: true)
        }
    }

    func numberOfTeams() -> Int { teams.count }
    func numberOfEvents() -> Int { events.count }
    func numberOfLatestResults() -> Int { latestResults.count }
    
    func getTeam(at index: Int) -> Team { teams[index] }
    func getEvent(at index: Int) -> Event { events[index] }
    func getLatestResult(at index: Int) -> LatestResult { latestResults[index] }
}

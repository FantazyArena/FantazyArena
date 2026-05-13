//
//  LeaguesPresenter.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

class LeaguesPresenter : LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private var leagues :[League] = []

    private let repository : SportsRepositoryProtocol
    private let sport : Sport

    init(view:LeaguesViewProtocol,
         repository: SportsRepositoryProtocol,
         sport: Sport){
        
        self.view = view
        self.repository = repository
        self.sport = sport
    }
    
    func viewDidLoad(){
        view?.showLoading()
        loadData(sport:sport)
    }
    
    
    func loadData(sport:Sport){
        Task {
            await MainActor.run {
                self.view?.showLoading()
            }

            do {
                let leagues = try await SportsRepository.shared.getLeagues(for: sport.type)
                self.leagues = leagues
                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.loadSportLeagues()
                }
            } catch {
                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    

    func getSportName() -> String {
        return sport.name
    }
    func getLeaguesCount()-> Int {
        return leagues.count
    }
    
    func getLeague(at index:Int)-> League {
        return leagues[index]
    }
    
    func didSelectLeague(at index:Int){
        
        let league = leagues[index]
        //todo navigate to LeagueDetails Screen
    }
    
}

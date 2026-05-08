//
//  LeaguesPresenter.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

class LeaguesPresenter : LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private var leagues :[League] = []

    private let repository : SportsRepositotyProtocol
    private let sport : Sport

    init(view:LeaguesViewProtocol,
         repository:SportsRepositotyProtocol,
         sport: Sport){
        
        self.view = view
        self.repository = repository
        self.sport = sport
    }
    
    func viewDidLoad(){
        view?.showLoading()
        
        repository.fetchLeagues(sport: sport) { [weak self] (result: Result<[League], Error>) in

                    guard let self = self else { return }

                    self.view?.hideLoading()

                    switch result {

                    case .success(let data):

                        self.leagues = data

                        if data.isEmpty {
                            self.view?.showEmpty()
                        } else {
                            self.view?.reloadData()
                        }

                    case .failure(let error):
                        self.view?.showError(message: error.localizedDescription)
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

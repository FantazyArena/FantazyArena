//
//  LeaguesPresenter.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

class LeaguesPresenter : LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private var leagues :[League] = [
        League(id: "id", name: "Gold", badgeURL: "", countryName: "Egypt")
    ]

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
        // TODO: fetch leagues
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

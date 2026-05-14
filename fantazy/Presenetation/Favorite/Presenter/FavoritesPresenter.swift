class FavoritesPresenter: FavoritesPresenterProtocol {
    
    private weak var view: FavoritesViewProtocol?
    private var favoriteLeagues: [FavoriteLeague] = []
    
    init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        self.favoriteLeagues = SportsRepository.shared.getAllFavorites()
        view?.hideLoading()
        view?.renderFavorites()
    }
    
    func getLeaguesCount() -> Int {
        return favoriteLeagues.count
    }
    
    func getLeague(by index: Int) -> FavoriteLeague {
        return favoriteLeagues[index]
    }
    
    func selectLeague(by index: Int) {
        
        if(NetworkMonitor.isConnected()){
            let fav = favoriteLeagues[index]
            
            let league = League(id: "\(fav.id)", name: fav.name ?? "", badgeURL: fav.logo ?? "", countryName: fav.country ?? "")
            view?.navigateToLeagueDetails(league: league)
        }else{
            view?.showNetworkAlert()
        }
    }
    
    func removeRequest(at index: Int) {
        let leagueToDelete = favoriteLeagues[index]
        let name = leagueToDelete.name ?? "this league"
        
        view?.showDeleteConfirmation(for: name) { [weak self] confirmed in
            if confirmed {
                let id = Int(leagueToDelete.id)
                LeagueDAO.shared.removeFavorite(id: id)
                self?.fetchData()
                
                self?.view?.showToast(message: "League deleted successfully", seconds: 1)
            }
        }
    }
}

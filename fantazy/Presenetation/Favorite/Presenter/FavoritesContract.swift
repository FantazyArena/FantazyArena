protocol FavoritesViewProtocol: AnyObject {
    func renderFavorites()
    func navigateToLeagueDetails(league: League)
    func showDeleteConfirmation(for leagueName: String, completion: @escaping (Bool) -> Void)
}

protocol FavoritesPresenterProtocol {
    func viewDidLoad()
    func getLeague(by index: Int) -> FavoriteLeague 
    func getLeaguesCount() -> Int
    func selectLeague(by index: Int)
    func removeRequest(at index: Int)
}

protocol FavoritesViewProtocol{
    func navigateToLeagueDetails(league: League)
}

protocol FavoritesPresenterProtocol {
    func getLeague(by index: Int) -> League
    func getLeaguesCount() -> Int
    func selectLeague(by index: Int)
}

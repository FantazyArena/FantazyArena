protocol HomePresenterProtocol {
    func viewDidLoad()
    func getSportsCount() -> Int
    func getSport(by index: Int) -> Sport
    func didSelectSport(sport: Sport)
}

protocol HomeViewProtocol {
    func navigateToSportDetails(sport: Sport)
    func displayNoInternetAlert()
}

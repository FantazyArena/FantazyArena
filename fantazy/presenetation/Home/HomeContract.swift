protocol HomePresenterProtocol {
    func viewDidLoad()
    func getSprotsCount() -> Int
    func getSport(by index: Int) -> Sport
    func onSelectSprot(sport: Sport)
}

protocol HomeViewProtocol {
    func navigateToSoprtDetails(sport: Sport)
}

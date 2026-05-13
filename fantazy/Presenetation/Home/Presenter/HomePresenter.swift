class HomePresenter: HomePresenterProtocol {
    
    let view: HomeViewProtocol
    let sports: Array<Sport>
    
    init(view: HomeViewProtocol){
        self.view = view
        
        sports = [
            Sport(name: "Football", thumbnail: "football"),
            Sport(name: "Basketball", thumbnail: "basketball"),
            Sport(name: "Cricket", thumbnail: "cricket"),
            Sport(name: "Tennis", thumbnail: "tennis"),
        ]
    }
    
    func viewDidLoad() {  }
    
    func getSportsCount() -> Int{
        return sports.count
    }
    
    func getSport(by index: Int) -> Sport{
        return sports[index]
    }
    
    func didSelectSport(sport: Sport) {

        let isConnect = NetworkMonitor.isConnected()
        
        if isConnect {
            view.navigateToSportDetails(sport: sport)
        } else {
            view.displayNoInternetAlert()
        }
    }
}

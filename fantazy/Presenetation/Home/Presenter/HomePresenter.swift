class HomePresenter: HomePresenterProtocol {
    
    let view: HomeViewProtocol
    let sports: Array<Sport>
    
    init(view: HomeViewProtocol){
        self.view = view
        
        sports = [
            Sport(name: "Football",type: .football, thumbnail: "football"),
            Sport(name: "Basketball",type: .basketball, thumbnail: "basketball"),
            Sport(name: "Cricket",type: .football, thumbnail: "cricket"),
            Sport(name: "Tennis",type: .football, thumbnail: "tennis"),
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
        
        if sport.name != "Football" && sport.name != "Basketball"{
            view.displayCommingSoonAlert()
        }else{
            if isConnect  {
                view.navigateToSportDetails(sport: sport)
            } else {
                view.displayNoInternetAlert()
            }
        }
        
    }
}

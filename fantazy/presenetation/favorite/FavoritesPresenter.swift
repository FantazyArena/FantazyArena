class FavoritesPresenter: FavoritesPresenterProtocol {
    
    let view: FavoritesViewProtocol
    
    let dummyData = [
        League(name: "Primuim", badgeURL: "", countryName: "Egypt"),
        League(name: "Silver", badgeURL: "", countryName: "Egypt"),
        League(name: "Gold", badgeURL: "", countryName: "Egypt"),
    ]
    
    init(view: FavoritesViewProtocol){
        self.view = view
    }
    
    func getLeaguesCount() -> Int{
        return dummyData.count
    }
    
    func getLeague(by index: Int) -> League{
        return dummyData[index]
    }
    
    func selectLeague(by index: Int){
        view.navigateToLeagueDetails(league: dummyData[index])
    }
}

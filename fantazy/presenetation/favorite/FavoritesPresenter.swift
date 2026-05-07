class FavoritesPresenter: FavoritesPresenterProtocol {
    
    let view: FavoritesViewProtocol
    
    let dummyData = [
        League(countryName: "Egypt", league: "Primuim", thumbnail: ""),
        League(countryName: "USA", league: "Silver", thumbnail: ""),
        League(countryName: "France", league: "Gold", thumbnail: ""),
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

class TeamDetailsPresenter: TeamDetailsPresenterProtocol{
    let view: TeamDetailsViewProtocol
    
    let team = TeamDetails(
        thumbnail: "barcelona_logo.jpg",
        name: "FC Barcelona",
        founded: "1899",
        stadium: "Camp Nou",
        national: "Xavi Hernández",
        players: [
            Player(name: "Lionel Messi", number: "10", position: "Forward", image: "messi.jpg"),
            Player(name: "Pedri", number: "8", position: "Midfielder", image: "pedri.jpg"),
            Player(name: "Ronald Araújo", number: "4", position: "Defender", image: "araujo.jpg"),
            Player(name: "Ter Stegen", number: "1", position: "Goalkeeper", image: "terstegen.jpg")
        ]
    )
    
    init(view: TeamDetailsViewProtocol){
        self.view = view
    }
     
    func playersCount() -> Int {
        return team.players.count
    }
    
    func getPlayer(with index: Int) -> Player {
        return team.players[index]
    }
    
    func onSocialClicked(with social: String) {
        print("\(social) Clicked")
    }
    
    func loadData() {
        view.loadTeam(team: team)
    }
}

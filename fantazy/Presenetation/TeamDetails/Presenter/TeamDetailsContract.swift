protocol TeamDetailsPresenterProtocol {
    func loadData()
    func playersCount() -> Int
    func getPlayer(with index: Int) -> Player
    func onSocialClicked(with social: String)
}

protocol TeamDetailsViewProtocol {
    func loadPlayers(players: [Player])
    func loadTeam(team: TeamDetails)
}

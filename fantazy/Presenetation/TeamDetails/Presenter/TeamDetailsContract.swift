protocol TeamDetailsPresenterProtocol {
    func loadData(teamName: String, sportType: SportType)
    func onSocialClicked(with social: SocialOption)
}

protocol TeamDetailsViewProtocol: AnyObject {
    func loadTeam(team: TeamDetails)
    func setLoading(with loading: Bool)
    func showError(_ message: String)
}

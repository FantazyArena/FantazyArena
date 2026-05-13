import Foundation
import UIKit

class TeamDetailsPresenter: TeamDetailsPresenterProtocol{
    weak var view: TeamDetailsViewProtocol?
    
    let team = TeamDetails(
        thumbnail: "barcelona_logo.jpg",
        name: "FC Barcelona",
        founded: "1899",
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

    func onSocialClicked(with social: SocialOption) {
        let urls: (app: String, web: String)
        let teamName = team.name
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: "_")
            .lowercased()
        
        switch social {
        case .youtube:
            urls = (app: "youtube://www.youtube.com/@\(teamName)",
                    web: "https://www.youtube.com/@\(teamName)")
        case .facebook:
            urls = (app: "fb://facewebmodal/f?href=https://www.facebook.com/\(teamName)",
                    web: "https://www.facebook.com/\(teamName)")
        case .twitter:
            urls = (app: "twitter://user?screen_name=\(teamName)",
                    web: "https://twitter.com/\(teamName)")
        }
        
        openURL(app: urls.app, web: urls.web)
    }

    private func openURL(app appURL: String, web webURL: String) {
        guard let appScheme = URL(string: appURL),
              let webFallback = URL(string: webURL) else { return }
        
        if UIApplication.shared.canOpenURL(appScheme) {
            UIApplication.shared.open(appScheme)
        } else {
            UIApplication.shared.open(webFallback)
        }
    }
    
    func loadData(teamName: String, sportType: SportType){
        Task {
            await MainActor.run {
                self.view?.setLoading(with: true)
            }

            do {
                let team = try await SportsRepository.shared.getTeamDetails(for: sportType, teamName: teamName)
                
                await MainActor.run {
                    self.view?.setLoading(with: false)
                    self.view?.loadTeam(team: team)
                }
            } catch {
                await MainActor.run {
                    self.view?.setLoading(with: false)
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}

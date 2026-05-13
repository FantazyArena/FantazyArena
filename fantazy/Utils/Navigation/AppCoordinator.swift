//
//  AppCoordinator.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 11/05/2026.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    
    func start() {

        let vc = LeaguesViewController(
            nibName: "LeaguesViewController",
            bundle: nil
        )
        vc.coordinator = self
        let sport = Sport(
            name: "Soccer",
            thumbnail: "football"
        )

        let repository = SportsRepository.shared

        vc.presenter = LeaguesPresenter(
            view: vc,
            repository: repository,
            sport: sport
        )

        navigationController.viewControllers = [vc]

        window.rootViewController = navigationController

        window.makeKeyAndVisible()
    }
}

extension AppCoordinator {

    func navigateToLeagues(sport: Sport) {

        let vc = LeaguesViewController(
            nibName: "LeaguesViewController",
            bundle: nil
        )

        let repository = SportsRepository.shared

        vc.presenter = LeaguesPresenter(
            view: vc,
            repository: repository,
            sport: sport
        )

        vc.coordinator = self

        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
}
extension AppCoordinator {

    func navigateToLeagueDetails(leagueId: String) {

        let vc = LeagueDetailsViewController(
            nibName: "LeagueDetailsViewController",
            bundle: nil
        )

        vc.leagueId = leagueId
        vc.coordinator = self

        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
}
extension AppCoordinator {

    func navigateToTeamDetails(team: Team) {

        let vc = TeamDetailsViewController(
            nibName: "TeamDetailsViewController",
            bundle: nil
        )

        vc.team = team

        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
}

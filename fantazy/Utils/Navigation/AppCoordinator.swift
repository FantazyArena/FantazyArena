//
//  AppCoordinator.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 11/05/2026.
//

import UIKit

final class AppCoordinator {

    static let shared = AppCoordinator()

    private init() {}


    private var window: UIWindow?

    private let tabBarController = UITabBarController()

    private let homeNavigationController = UINavigationController()
    private let favoritesNavigationController = UINavigationController()
    private let settingsNavigationController = UINavigationController()


    func configure(window: UIWindow) {
        self.window = window
    }


    func start() {

        setupHomeTab()
        setupFavoritesTab()
        setupSettingsTab()

        tabBarController.viewControllers = [
            homeNavigationController,
            favoritesNavigationController,
            settingsNavigationController
        ]

        tabBarController.selectedIndex = 0

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}


private extension AppCoordinator {

    func setupHomeTab() {

        let vc = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil
        )

        vc.coordinator = self
        vc.presenter = HomePresenter(view: vc)

        homeNavigationController.viewControllers = [vc]

        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
    }

    func setupFavoritesTab() {

        let vc = FavoritesViewController(
            nibName: "FavoritesViewController",
            bundle: nil
        )

        favoritesNavigationController.viewControllers = [vc]

        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
    }

    func setupSettingsTab() {

        let vc = SettingsViewController(
            nibName: "SettingsViewController",
            bundle: nil
        )

        settingsNavigationController.viewControllers = [vc]

        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
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

        homeNavigationController.pushViewController(
            vc,
            animated: true
        )
    }

    func navigateToLeagueDetails(leagueId: String) {

        let vc = LeagueDetailsViewController(
            nibName: "LeagueDetailsViewController",
            bundle: nil
        )

        vc.leagueId = leagueId
        vc.coordinator = self

        homeNavigationController.pushViewController(
            vc,
            animated: true
        )
    }

    func navigateToTeamDetails(team: Team) {

        let vc = TeamDetailsViewController(
            nibName: "TeamDetailsViewController",
            bundle: nil
        )

        vc.team = team

        homeNavigationController.pushViewController(
            vc,
            animated: true
        )
    }
}

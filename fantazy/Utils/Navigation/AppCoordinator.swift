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
        if UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
            showMainApp(animated: false)
        } else {
            showOnboarding()
        }
        window?.makeKeyAndVisible()
    }

    func showOnboarding() {
        let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let presenter = OnboardingPresenter(view: vc)
        
        presenter.onFinish = { [weak self] in
            self?.handleOnboardingFinish()
        }
        
        vc.presenter = presenter
        window?.rootViewController = vc
    }

    private func handleOnboardingFinish() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        showMainApp(animated: true)
    }

    func showMainApp(animated: Bool) {
        setupHomeTab()
        setupFavoritesTab()
        setupSettingsTab()

        tabBarController.viewControllers = [
            homeNavigationController,
            favoritesNavigationController,
            settingsNavigationController
        ]

        window?.rootViewController = tabBarController
        
        if animated, let window = window {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }

    private func setupHomeTab() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        vc.coordinator = self
        homeNavigationController.viewControllers = [vc]
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    }

    private func setupFavoritesTab() {
        let vc = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
        favoritesNavigationController.viewControllers = [vc]
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    }

    private func setupSettingsTab() {
        let vc = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsNavigationController.viewControllers = [vc]
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
    }
}

extension AppCoordinator {
    func navigateToLeagues(sport: Sport) {
        let vc = LeaguesViewController(nibName: "LeaguesViewController", bundle: nil)
        vc.presenter = LeaguesPresenter(view: vc, repository: SportsRepository.shared, sport: sport)
        vc.coordinator = self
        homeNavigationController.pushViewController(vc, animated: true)
    }

    func navigateToLeagueDetails(leagueId: String) {
        let vc = LeagueDetailsViewController(nibName: "LeagueDetailsViewController", bundle: nil)
        vc.leagueId = leagueId
        vc.coordinator = self
        homeNavigationController.pushViewController(vc, animated: true)
    }

    func navigateToTeamDetails(team: Team) {

        let vc = TeamDetailsViewController(
            nibName: "TeamDetailsViewController",
            bundle: nil
        )

        vc.players = team.players
        vc.coach = team.coach
        vc.teamName = team.name
        vc.sportType = .football

        homeNavigationController.pushViewController(
            vc,
            animated: true
        )
    }
}

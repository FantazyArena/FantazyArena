//
//  LeagueDetailsViewController.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import UIKit

class LeagueDetailsViewController: UIViewController {


    @IBOutlet var leagueImage: UIImageView!
    @IBOutlet var leagueName: UILabel!
    @IBOutlet var leagueCountryName: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!

    private var activityIndicator: UIActivityIndicatorView!

    private var favoriteBarButton: UIBarButtonItem!

    var presenter: LeagueDetailsPresenterProtocol!

    var leagueId: String?

    weak var coordinator: AppCoordinator?
    
    enum Section: Int, CaseIterable {
        case teams = 0
        case events = 1
        case latestResults = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupNavigationBar()
        setupCollectionView()
        setupActivityIndicator()
        presenter.viewDidLoad()
    }


    private func setupPresenter() {

        guard let leagueId = leagueId else { return }

        let presenter = LeagueDetailsPresenter(
            leagueId: leagueId
        )

        presenter.view = self

        self.presenter = presenter
    }
    
    private func setupNavigationBar() {

        title = "League Details"

        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        favoriteBarButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
        favoriteBarButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = favoriteBarButton
    }

    @objc private func favoriteTapped() {
        presenter.toggleFavorite()
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    private func setupCollectionView() {

        collectionView.register(
            UINib(nibName: "TeamCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: TeamCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            UINib(nibName: "EventCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier
        )
        collectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.reuseIdentifier)
        
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = createCompositionalLayout()
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
  
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self,
                  let section = Section(rawValue: sectionIndex) else { return nil }

            switch section {
                case .teams:  return self.makeTeamsSection()
                case .events: return self.makeEventsSection()
                case .latestResults: return self.makeLatestResultsSection()
            }
        }
    }

    private func makeLatestResultsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(220)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 12, bottom: 0, trailing: 0
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(220)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.boundarySupplementaryItems = [makeSectionHeader()]
        return section
    }
    
    private func makeTeamsSection() -> NSCollectionLayoutSection {
 
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 12, bottom: 0, trailing: 0
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(120)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
  
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8

        section.boundarySupplementaryItems = [makeSectionHeader()]
        return section
    }

    private func makeEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 12, bottom: 0, trailing: 0
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 12
        section.boundarySupplementaryItems = [makeSectionHeader()]
        return section
    }

    private func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(58)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}


extension LeagueDetailsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
            case .teams:  return presenter.numberOfTeams()
            case .events: return presenter.numberOfEvents()
            case .latestResults: return presenter.numberOfLatestResults()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch section {
            case .teams:
            
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeamCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as! TeamCollectionViewCell
                cell.configure(with: presenter.getTeam(at: indexPath.item))
                return cell

            case .events:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as! EventCollectionViewCell
                cell.configure(with: presenter.getEvent(at: indexPath.item))
                return cell
            case .latestResults:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ResultCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as! ResultCollectionViewCell
                cell.configure(with: presenter.getLatestResult(at: indexPath.item))
                return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
            for: indexPath
        ) as! SectionHeaderReusableView

        switch Section(rawValue: indexPath.section) {
            case .teams:  header.configure(title: "Teams")
            case .events: header.configure(title: "Upcoming Matches")
            case .latestResults: header.configure(title: "Latest Results")
            case .none: break
        }
        
        return header
    }
}

extension LeagueDetailsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
            case .teams:
                let team = presenter.getTeam(at: indexPath.item)
                coordinator?.navigateToTeamDetails(team: team)
            case .events:
                let event = presenter.getEvent(at: indexPath.item)
                print("Tapped event: \(event.homeTeam.name) vs \(event.awayTeam.name)")
            case .latestResults:
                let result = presenter.getLatestResult(at: indexPath.item)
                print("Tapped result: \(result.homeTeamName) vs \(result.awayTeamName)")
        }
    }
}


extension LeagueDetailsViewController: LeagueDetailsViewProtocol {

    func reloadTeams() {
        
        collectionView.reloadSections(IndexSet(integer: Section.teams.rawValue))
    }

    func reloadEvents() {
        collectionView.reloadSections(IndexSet(integer: Section.events.rawValue))
        
        collectionView.reloadSections(IndexSet(integer: Section.latestResults.rawValue))
    }

    func updateFavoriteState(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteBarButton.image = UIImage(systemName: imageName)
    }
    
    func loadLeagueDetails(league: League){
        // Test with named image
        self.leagueImage.image = UIImage(named: "football")
        
        //TODO: get the image using SDWebImage
        self.leagueName.text = league.name ?? ""
        self.leagueCountryName.text = league.countryName ?? ""
    }
}

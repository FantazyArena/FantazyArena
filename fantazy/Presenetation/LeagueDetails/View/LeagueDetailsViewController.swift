//
//  LeagueDetailsViewController.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//
import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController {

    @IBOutlet var leagueImage: UIImageView!
    @IBOutlet var leagueName: UILabel!
    @IBOutlet var leagueCountryName: UILabel!
    
    @IBOutlet weak var emptyData: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var collectionView: UICollectionView!

    private var favoriteBarButton: UIBarButtonItem!

    var presenter: LeagueDetailsPresenterProtocol!

    var leagueId: String?
    var sportType :SportType?
    weak var coordinator: AppCoordinator?
    var currentLeague :League?
    
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
        loadLeagueDetails(league:currentLeague!)
        presenter.viewDidLoad()
        presenter.loadLeagueDetails()
    }

    private func setupPresenter() {
        guard let leagueId = leagueId else { return }

        let presenter = LeagueDetailsPresenter(
            leagueId: leagueId ,
            sportType: sportType ?? .football,
            currentLeague: currentLeague!
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

        updateFavoriteState(isFavorite: presenter.isFavorite())
    }
    
    @objc private func favoriteTapped() {
        presenter.toggleFavorite()
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

            let itemCount = self.collectionView(self.collectionView, numberOfItemsInSection: sectionIndex)
            if itemCount == 0 {
                return self.makeEmptySection()
            }

            switch section {
                case .teams:  return self.makeTeamsSection()
                case .events: return self.makeEventsSection()
                case .latestResults: return self.makeLatestResultsSection()
            }
        }
    }

    private func makeEmptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0.1), heightDimension: .absolute(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
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

        let itemCount = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section)
        
        if itemCount == 0 {
            header.isHidden = true
        } else {
            header.isHidden = false
            switch Section(rawValue: indexPath.section) {
                case .teams:  header.configure(title: "Teams")
                case .events: header.configure(title: "Upcoming Matches")
                case .latestResults: header.configure(title: "Latest Results")
                case .none: break
            }
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
    
    func showLoading() {
        loadingIndicator.startAnimating()
        collectionView.isHidden = true
        errorLabel.isHidden = true
        emptyData.isHidden = true
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        collectionView.isHidden = false
    }
    
    func reloadLeagueDetails() {
        let hasData = presenter.numberOfTeams() > 0 || presenter.numberOfEvents() > 0 || presenter.numberOfLatestResults() > 0
        if hasData {
            emptyData.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        } else {
            showEmptyState()
        }
    }
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        collectionView.isHidden = true
    }
    
    func showEmptyState() {
        emptyData.isHidden = false
        collectionView.isHidden = true
    }

    func reloadTeams() {
        collectionView.reloadData()
    }

    func reloadEvents() {
        collectionView.reloadData()
    }

    func updateFavoriteState(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteBarButton.image = UIImage(systemName: imageName)
    }
    
    func loadLeagueDetails(league: League) {
        if let imageUrlString = league.badgeURL, let url = URL(string: imageUrlString) {
            self.leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "football"))
        } else {
            self.leagueImage.image = UIImage(named: "football")
        }
        
        self.leagueName.text = league.name ?? ""
        self.leagueCountryName.text = league.countryName ?? ""
    }
}

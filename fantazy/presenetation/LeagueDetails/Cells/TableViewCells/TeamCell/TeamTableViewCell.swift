//
//  TeamTableViewCell.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var teams: [Team] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            UINib(nibName: "TeamCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TeamCollectionViewCell"
        )
    }

    
    func configure(with teams: [Team]) {
        self.teams = teams
        collectionView.reloadData()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { _, _ in

            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(140),
                    heightDimension: .absolute(170)
                ),
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 12
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 10, leading: 16, bottom: 10, trailing: 16
            )

            return section
        }
    }
}

extension TeamsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TeamCollectionViewCell",
            for: indexPath
        ) as! TeamCollectionViewCell

        cell.configure(with: teams[indexPath.row])
        return cell
    }
}

//
//  TeamCollectionViewCell.swift
//  fantazy
//

import UIKit
import SDWebImage

class TeamCollectionViewCell: UICollectionViewCell {

    // MARK: - UI

    private let badgeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.systemGray5.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.addSubview(badgeImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            // Circle image — centered, 70x70
            badgeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            badgeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            badgeImageView.widthAnchor.constraint(equalToConstant: 70),
            badgeImageView.heightAnchor.constraint(equalToConstant: 70),

            // Name below image
            nameLabel.topAnchor.constraint(equalTo: badgeImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Make it a perfect circle after layout
        badgeImageView.layer.cornerRadius = badgeImageView.frame.width / 2
    }

    // MARK: - Configure

    func configure(with team: Team) {
        nameLabel.text = team.name

        if let urlStr = team.badgeURL, let url = URL(string: urlStr) {
            badgeImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(systemName: "sportscourt.fill"),
                options: [.highPriority]
            )
        } else {
            badgeImageView.image = UIImage(systemName: "sportscourt.fill")
            badgeImageView.tintColor = .systemGray3
        }
    }
}

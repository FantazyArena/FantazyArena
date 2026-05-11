//
//  EventCollectionViewCell.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {


    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let homeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.image = UIImage(systemName: "sportscourt")
        iv.tintColor = .systemGray3
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let awayImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.image = UIImage(systemName: "sportscourt")
        iv.tintColor = .systemGray3
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let vsLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .systemFont(ofSize: 12, weight: .black)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let homeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let awayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusBadge: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }


    private func setupUI() {
        contentView.addSubview(containerView)

        containerView.addSubview(homeImageView)
        containerView.addSubview(vsLabel)
        containerView.addSubview(awayImageView)
        containerView.addSubview(homeNameLabel)
        containerView.addSubview(awayNameLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(statusBadge)

        NSLayoutConstraint.activate([

            // Container fills cell
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

            // Status badge — top right
            statusBadge.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            statusBadge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            statusBadge.heightAnchor.constraint(equalToConstant: 16),
            statusBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 36),

            // Home image — left side
            homeImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            homeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            homeImageView.widthAnchor.constraint(equalToConstant: 44),
            homeImageView.heightAnchor.constraint(equalToConstant: 44),

            // VS label — center
            vsLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            vsLabel.centerYAnchor.constraint(equalTo: homeImageView.centerYAnchor),

            // Away image — right side
            awayImageView.topAnchor.constraint(equalTo: homeImageView.topAnchor),
            awayImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            awayImageView.widthAnchor.constraint(equalToConstant: 44),
            awayImageView.heightAnchor.constraint(equalToConstant: 44),

            // Home name label
            homeNameLabel.topAnchor.constraint(equalTo: homeImageView.bottomAnchor, constant: 6),
            homeNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            homeNameLabel.widthAnchor.constraint(equalToConstant: 70),

            // Away name label
            awayNameLabel.topAnchor.constraint(equalTo: awayImageView.bottomAnchor, constant: 6),
            awayNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            awayNameLabel.widthAnchor.constraint(equalToConstant: 70),

            // Time label
            timeLabel.topAnchor.constraint(equalTo: homeNameLabel.bottomAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            // Date label
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
    }


    func configure(with event: Event) {
        homeNameLabel.text = event.homeTeam.name
        awayNameLabel.text = event.awayTeam.name
        timeLabel.text = event.time
        dateLabel.text = event.date

        configureStatus(event.status)

        // Load images if available
        if let urlStr = event.homeTeam.badgeURL, let url = URL(string: urlStr) {
            homeImageView.sd_setImage(with: url,
                placeholderImage: UIImage(systemName: "sportscourt"))
        } else {
            homeImageView.image = UIImage(systemName: "sportscourt")
        }

        if let urlStr = event.awayTeam.badgeURL, let url = URL(string: urlStr) {
            awayImageView.sd_setImage(with: url,
                placeholderImage: UIImage(systemName: "sportscourt"))
        } else {
            awayImageView.image = UIImage(systemName: "sportscourt")
        }
    }

    private func configureStatus(_ status: EventStatus) {
        switch status {
        case .upcoming:
            statusBadge.text = " Soon "
            statusBadge.backgroundColor = .systemBlue
        case .live:
            statusBadge.text = " Live "
            statusBadge.backgroundColor = .systemRed
        case .finished:
            statusBadge.text = " Done "
            statusBadge.backgroundColor = .systemGray
        }
    }
}

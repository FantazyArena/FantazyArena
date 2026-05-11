//
//  EventCollectionViewCell.swift
//  fantazy
//

import UIKit
import SDWebImage

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var awayNameLabel: UILabel!

    static let reuseIdentifier = "EventCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    private func setupAppearance() {
        // Card
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true

        // Date label
        dateTimeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        dateTimeLabel.textColor = .systemBlue
        dateTimeLabel.textAlignment = .center

        [homeImageView, awayImageView].forEach {
            $0?.contentMode = .scaleAspectFill
            $0?.clipsToBounds = true
            $0?.backgroundColor = .tertiarySystemBackground
        }

        // VS label
        vsLabel.text = "VS"
        vsLabel.font = .systemFont(ofSize: 15, weight: .black)
        vsLabel.textColor = .label
        vsLabel.textAlignment = .center

        // Team name labels
        [homeNameLabel, awayNameLabel].forEach {
            $0?.font = .systemFont(ofSize: 12, weight: .medium)
            $0?.textColor = .label
            $0?.textAlignment = .center
            $0?.numberOfLines = 2
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        homeImageView.layer.cornerRadius = homeImageView.bounds.width / 2
        awayImageView.layer.cornerRadius = awayImageView.bounds.width / 2
    }

    func configure(with event: Event) {
        dateTimeLabel.text = "\(event.date)  •  \(event.time)"
        homeNameLabel.text = event.homeTeam.name
        awayNameLabel.text = event.awayTeam.name
        loadImage(into: homeImageView, urlStr: event.homeTeam.badgeURL)
        loadImage(into: awayImageView, urlStr: event.awayTeam.badgeURL)
    }

    private func loadImage(into imageView: UIImageView, urlStr: String?) {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            imageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(systemName: "sportscourt.fill")
            )
        } else {
            imageView.image = UIImage(systemName: "sportscourt.fill")
            imageView.tintColor = .secondaryLabel
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        homeImageView.image = nil
        awayImageView.image = nil
        homeImageView.sd_cancelCurrentImageLoad()
        awayImageView.sd_cancelCurrentImageLoad()
    }
}

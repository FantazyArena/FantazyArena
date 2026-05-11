
import UIKit
import SDWebImage

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ringView: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    static let reuseIdentifier = "TeamCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

 
    private func setupAppearance() {

        // Ring view styling
        ringView.backgroundColor = .clear
        ringView.layer.cornerRadius = 38
        ringView.layer.borderWidth = 2.5
        ringView.layer.borderColor = UIColor.separator.cgColor
        ringView.layer.shadowOpacity = 0.35
        ringView.layer.shadowOffset = CGSize(width: 0, height: 0)

        updateShadowColor()

        // Badge image
        badgeImageView.contentMode = .scaleAspectFill
        badgeImageView.clipsToBounds = true
        badgeImageView.layer.cornerRadius = 35
        badgeImageView.backgroundColor = .secondarySystemBackground

        // Name label
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }

    private func updateShadowColor() {
        ringView.layer.shadowColor = UIColor.label.cgColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateShadowColor()
        ringView.layer.borderColor = UIColor.separator.cgColor
    }

    func configure(with team: Team) {
        nameLabel.text = team.name

        if let urlStr = team.thumbnail, let url = URL(string: urlStr) {

            badgeImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(systemName: "sportscourt.fill")
            )
        } else {
            badgeImageView.image = UIImage(systemName: "sportscourt.fill")
            badgeImageView.tintColor = .secondaryLabel
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeImageView.image = nil
        badgeImageView.sd_cancelCurrentImageLoad()
    }
}

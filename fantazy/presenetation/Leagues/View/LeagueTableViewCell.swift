import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!


    private let gradientLayer = CAGradientLayer()


    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupGradient()

        badgeImageView.layer.cornerRadius =
            badgeImageView.frame.width / 2
    }


    private func setupUI() {

        backgroundColor = .clear

        contentView.backgroundColor = .clear

        selectionStyle = .none

        // Container

        containerView.layer.cornerRadius = 12

        containerView.layer.shadowColor = UIColor.black.cgColor

        containerView.layer.shadowOpacity = 0.1

        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)

        containerView.layer.shadowRadius = 6

        containerView.layer.masksToBounds = false

        containerView.layer.borderWidth = 1

        containerView.layer.borderColor =
            AppColors.border.cgColor

        // Badge Image

        badgeImageView.clipsToBounds = true

        badgeImageView.contentMode = .scaleAspectFill

        badgeImageView.backgroundColor = AppColors.muted

        // Label

        leagueNameLabel.textColor = AppColors.foreground

        // Arrow

        arrowImage.image = UIImage(systemName: "chevron.right")

        arrowImage.tintColor = AppColors.mutedForeground
    }

    private func setupGradient() {

        gradientLayer.frame = containerView.bounds

        gradientLayer.colors = [
            AppColors.card.cgColor,
            AppColors.background.cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)

        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        gradientLayer.cornerRadius = 12

        if gradientLayer.superlayer == nil {

            containerView.layer.insertSublayer(
                gradientLayer,
                at: 0
            )
        }
    }

    
    func configure(with league: League) {

        leagueNameLabel.text = league.name

        if let badgeURL = league.badgeURL,
           let url = URL(string: badgeURL) {

            badgeImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(systemName: "sportscourt"),
                options: [
                    .highPriority,
                    .continueInBackground,
                    .progressiveLoad
                ],
                completed: nil
            )

        } else {

            badgeImageView.image =
                UIImage(systemName: "sportscourt")
        }
    }


    func animateSelection() {

        UIView.animate(withDuration: 0.1,
                       animations: {

            self.containerView.transform =
                CGAffineTransform(scaleX: 0.97, y: 0.97)

        }) { _ in

            UIView.animate(withDuration: 0.1) {

                self.containerView.transform = .identity
            }
        }
    }
}

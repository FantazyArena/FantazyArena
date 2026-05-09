//
//  LeagueTableViewCell.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    private let gradientLayer = CAGradientLayer()

    @IBOutlet weak var arrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgeImageView.clipsToBounds = true
        badgeImageView.contentMode = .scaleAspectFill
        containerView.layer.cornerRadius = 12

        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 6
        containerView.layer.masksToBounds = false
        selectionStyle = .none
//        accessoryType = .disclosureIndicator
        arrowImage.image = UIImage(systemName: "chevron.right")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        badgeImageView.layer.cornerRadius = badgeImageView.frame.width / 2
        
        gradientLayer.frame = containerView.bounds

        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.systemGray6.cgColor
        ]

        gradientLayer.cornerRadius = 12

        if gradientLayer.superlayer == nil {
            containerView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func animateSelection() {

        UIView.animate(withDuration: 0.1, animations: {

            self.containerView.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)

        }) { _ in

            UIView.animate(withDuration: 0.1) {
                self.containerView.transform = .identity
            }
        }
    }
    
    func configure(with league: League) {

        leagueNameLabel.text = league.name

        badgeImageView.sd_setImage(
            with: URL(string: league.badgeURL!),
            placeholderImage: UIImage(systemName: "premier"),
            options: [.highPriority, .continueInBackground, .progressiveLoad],
            completed: nil
        )
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

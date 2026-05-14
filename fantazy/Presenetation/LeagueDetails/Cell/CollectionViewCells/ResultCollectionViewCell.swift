//
//  ResultCollectionViewCell.swift
//  fantazy
//
//  Created by Mohamed Amir on 11/05/2026.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ResultCollectionViewCell"
    
    @IBOutlet var result: UILabel!
    @IBOutlet var awayTeamName: UILabel!
    @IBOutlet var awayTeamImage: UIImageView!
    @IBOutlet var homeTeamImage: UIImageView!
    @IBOutlet var homeTeamName: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with result: LatestResult){
        self.result.text = result.result
        self.homeTeamName.text = result.homeTeamName
        self.awayTeamName.text = result.awayTeamName
        self.date.text = result.date
        
        self.homeTeamImage.sd_setImage(
            with: URL(string: result.homeTeamLogo),
            placeholderImage: UIImage(systemName: "sportscourt.fill")
        )
        self.awayTeamImage.sd_setImage(
            with: URL(string:result.awayTeamLogo),
            placeholderImage: UIImage(systemName: "sportscourt.fill")
        )
    
    }
}

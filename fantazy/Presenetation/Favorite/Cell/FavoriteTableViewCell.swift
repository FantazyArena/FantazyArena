import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var leagueImage: UIImageView!
    
    @IBOutlet var leagueName: UILabel!
    
    @IBOutlet var countryName: UILabel!
    
    @IBOutlet var card: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        card.layer.cornerRadius = 12
        card.clipsToBounds = true
        
        leagueImage.layer.cornerRadius = leagueImage.frame.width
        leagueImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(with league: FavoriteLeague){
        
        self.leagueImage.sd_setImage(
            with: URL(string: league.logo ?? ""),
            placeholderImage: UIImage(systemName: "footballcourt")
        )
        
        leagueName.text = league.name
        countryName.text = league.country
    }
}

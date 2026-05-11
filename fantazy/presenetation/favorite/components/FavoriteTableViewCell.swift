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
    
    func config(with league: League){
        //TODO: get image using sdkWebImage
        leagueImage.image = UIImage(named: "Football") // Testing
        
        leagueName.text = league.league
        countryName.text = league.countryName
    }
}

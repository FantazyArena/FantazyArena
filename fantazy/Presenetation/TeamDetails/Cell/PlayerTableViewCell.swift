import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var playerName: UILabel!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var playerPosition: UILabel!
    @IBOutlet var playerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with player: Player){
        //Test the image
        playerImage.image = UIImage(named: "football")
        
        //TODO: get the image using SDWebImage
        playerName.text = player.name
        // playerImage.text = player.image
        playerPosition.text = player.position
        playerNumber.text = player.number
    }
}

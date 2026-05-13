import UIKit

enum Corners{
    case top
    case bottom
    case none
}

class PlayerTableViewCell: UITableViewCell {
    private var corners: Corners = .none
    
    @IBOutlet var playerName: UILabel!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var playerPosition: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var playerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch corners {
        case .top:
            view.roundCorners([.topLeft, .topRight], radius: 16)
        case .bottom:
            view.roundCorners([.bottomLeft, .bottomRight], radius: 16)
        case .none:
            view.roundCorners([], radius: 0)
        }
    }
    
    func config(with player: Player, cornerRadius: Corners){
        self.corners = cornerRadius
        
        playerImage.image = UIImage(named: "football")
        
        //TODO: get the image using SDWebImage
        playerName.text = player.name
        // playerImage.text = player.image
        playerPosition.text = player.position
        playerNumber.text = player.number
    }
}

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    @IBOutlet var sportImage: UIImageView!
    
    @IBOutlet var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with sport: Sport){
        sportImage.image = UIImage(named: sport.thumbnail)
        sportName.text = sport.name
        
        sportImage.layer.cornerRadius = 12.0
        sportImage.clipsToBounds = true
    }
}

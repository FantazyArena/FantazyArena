import UIKit

class SwitchSettingOptionTableViewCell: UITableViewCell {

    static let reusableIdentifier = "SwitchSettingOptionTableViewCell"
    
    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!

    var onValueChanged: ((Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(with option: SettingOption, isDark: Bool, onChange: @escaping (Bool) -> Void) {
        optionName.text = option.name
        
        switch option.optionIcon {
        case .darkMode:
            optionImage.image = UIImage(named: "darkMode")
        }

        self.onValueChanged = onChange
        self.toggleSwitch.isOn = isDark
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        onValueChanged?(sender.isOn)
    }
}

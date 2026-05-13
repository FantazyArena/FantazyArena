import UIKit

class SettingsPreseneter: SettingsPresenterProtocol {
    
    let view: SettingsViewProtocol
    
    let options = [
        SettingOption(name: "Dark Mode", cellId: SwitchSettingOptionTableViewCell.reusableIdentifier, type: .switchOption, icon: .darkMode, action: .changeAppearance)
    ]
    
    init(view: SettingsViewProtocol){
        self.view = view
    }
    
    func onViewDidLoad(){
        view.loadSettings(options: options)
    }
    
    func getOptionsCount() -> Int{
        return options.count
    }
    
    func getOption(at index: Int) -> SettingOption{
        return options[index]
    }
    
    func onChangeAppearance(value: Bool){
        let style: UIUserInterfaceStyle = value ? .dark : .light
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
    }
    
    func isDarkMode() -> Bool {
        //TODO: check if is it dark mode using user defaults
        return false
    }
}

class SettingOption{
    let name: String
    let cellId: String
    let optionIcon: SettingOptionIcon
    let type: SettingOptionType
    let action: SettingOptionAction
    
    init(name: String, cellId: String, type: SettingOptionType, icon: SettingOptionIcon, action: SettingOptionAction){
        self.name = name
        self.type = type
        self.optionIcon = icon
        self.action = action
        self.cellId = cellId
    }
}


enum SettingOptionType {
    case switchOption
}

enum SettingOptionIcon {
    case darkMode
}

enum SettingOptionAction {
    case changeAppearance
}

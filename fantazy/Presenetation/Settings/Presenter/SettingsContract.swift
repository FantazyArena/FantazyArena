protocol SettingsViewProtocol {
    func loadSettings(options: [SettingOption])
}

protocol SettingsPresenterProtocol {
    func onViewDidLoad()
    func getOptionsCount() -> Int
    func getOption(at: Int) -> SettingOption
    func onChangeAppearance(value: Bool)
    func isDarkMode() -> Bool
}

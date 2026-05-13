import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingsViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: SettingsPresenterProtocol!
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: "SettingsViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingsPreseneter(view: self)
        presenter.onViewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getOptionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = presenter.getOption(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchSettingOptionTableViewCell", for: indexPath) as! SwitchSettingOptionTableViewCell
        
        var onValueChanged: ((Bool) -> Void)
        switch(option.action) {
        case .changeAppearance: onValueChanged = presenter.onChangeAppearance
        }

        cell.config(with: option, isDark: presenter.isDarkMode(), onChange: onValueChanged)
        
        return cell
    }
    
    func loadSettings(options: [SettingOption]){
        let cells = Array(Set(options.map { $0.cellId }))
        
        for cell in cells {
            tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
}

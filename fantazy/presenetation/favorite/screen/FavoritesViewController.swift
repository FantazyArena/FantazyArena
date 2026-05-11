import UIKit

class FavoritesViewController: UIViewController,
                               UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol{

    @IBOutlet var tableView: UITableView!
    
    var presenter: FavoritesPresenterProtocol!
    
    override func loadView() {
        super.loadView()

        let nib = UINib(nibName: "FavoritesViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLeaguesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        cell.config(with: presenter.getLeague(by: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectLeague(by: indexPath.row)
    }
    
    func navigateToLeagueDetails(league: League){
        //TODO: navigate to league details screen
    }
}

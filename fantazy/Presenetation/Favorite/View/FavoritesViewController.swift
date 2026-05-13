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
        presenter.viewDidLoad()
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
        print("clicked")
        AppCoordinator.shared.navigateToLeagueDetails(leagueId: league.id!, sportType:.football, league: league)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidLoad()
    }
    func renderFavorites() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeRequest(at: indexPath.row)
        }
    }
    
    func showDeleteConfirmation(for leagueName: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
                title: "Remove Favorite",
                message: "Do you want to remove \(leagueName) from favorites?",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(false)
            })
            
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
                completion(true)
            })
            
            present(alert, animated: true)
    }
}

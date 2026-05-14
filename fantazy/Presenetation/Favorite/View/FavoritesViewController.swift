import UIKit

class FavoritesViewController: UIViewController,
                               UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {
    
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var presenter: FavoritesPresenterProtocol!

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "FavoritesViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        
        setupActivityIndicator()
        
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        emptyLabel.isHidden = true
        
        presenter.viewDidLoad()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.tableView.isUserInteractionEnabled = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isUserInteractionEnabled = true
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeRequest(at: indexPath.row)
        }
    }
    
    func navigateToLeagueDetails(league: League) {
        AppCoordinator.shared.navigateToLeagueDetails(leagueId: league.id!, sportType: .football, league: league)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidLoad()
        renderFavorites()
    }
    
    func renderFavorites() {
        emptyLabel.isHidden = presenter.getLeaguesCount() != 0
        tableView.reloadData()
    }
    
    func showDeleteConfirmation(for leagueName: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: "Remove Favorite",
            message: "Do you want to remove \(leagueName) from favorites?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion(false) })
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in completion(true) })
        present(alert, animated: true)
    }
    
    func showToast(message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func showNetworkAlert() {
        showNoInternetAlert()
    }
}

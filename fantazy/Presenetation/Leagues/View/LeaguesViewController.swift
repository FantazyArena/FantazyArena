//
//  LeaguesViewController.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

import UIKit

class LeaguesViewController: UIViewController ,
                             UITableViewDelegate,
                             UITableViewDataSource,
                             LeaguesViewProtocol {

    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    weak var coordinator: AppCoordinator?
    
    var presenter: LeaguesPresenterProtocol!
    var sport:Sport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    
    private func setupUI() {

        setupTheme()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "LeagueTableViewCell", bundle: nil),
            forCellReuseIdentifier: "LeagueTableViewCell"
        )

        hideAllStates()
    }
    
    private func setupTheme() {

          title = "Leagues"
          view.backgroundColor = .systemBackground
          navigationItem.largeTitleDisplayMode = .never

          navigationController?.navigationBar.titleTextAttributes = [
              .font: UIFont.boldSystemFont(ofSize: 25)
          ]

          navigationController?.navigationBar.tintColor = AppColors.primary

          sportName.text = presenter.getSportName()
          sportName.textColor = AppColors.foreground

          emptyLabel.textColor = AppColors.mutedForeground

          errorLabel.textColor = AppColors.destructive

          tableView.backgroundColor = .clear
          tableView.separatorStyle = .none

          loadingIndicator.color = AppColors.primary
      }
    
    func loadSportLeagues() {
        tableView.reloadData()
    }
    private func hideAllStates() {

        loadingIndicator.isHidden = true

        emptyLabel.isHidden = true

        errorLabel.isHidden = true
    }
    
    
    func showLoading() {

        hideAllStates()

        loadingIndicator.isHidden = false

        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {

        loadingIndicator.stopAnimating()

        loadingIndicator.isHidden = true
    }
    
    func showEmpty() {

        hideAllStates()

        emptyLabel.isHidden = false
    }
    
    func showError(message: String) {

        hideAllStates()

        errorLabel.isHidden = false

        errorLabel.text = message
    }
    
    func reloadData() {

        hideAllStates()

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return presenter.getLeaguesCount()
    }
    
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)-> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueTableViewCell",
            for: indexPath
        ) as! LeagueTableViewCell

        let league = presenter.getLeague(at: indexPath.row)

        cell.configure(with: league)

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? LeagueTableViewCell
        cell?.animateSelection()
        
        let league = presenter.getLeague(at: indexPath.row)

        coordinator?.navigateToLeagueDetails(
            leagueId: league.id ?? "",
            sportType:sport?.type ?? .football,
            league:league
        )
    }
    
}

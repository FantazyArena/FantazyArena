import UIKit

class TeamDetailsViewController: UIViewController, TeamDetailsViewProtocol,
                                 UITableViewDelegate, UITableViewDataSource{
    var preseneter: TeamDetailsPresenterProtocol!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var banner: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var facebook: UIView!
    @IBOutlet var twitter: UIView!
    @IBOutlet var youtube: UIView!
    
    @IBOutlet var teamCountry: UILabel!
    @IBOutlet var teamCoach: UILabel!
    @IBOutlet var teamFoundedDate: UILabel!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var teamImage: UIImageView!
    
    @IBOutlet var loadingSection: UIView!
    
    var teamName: String?
    var sportType: SportType? = .football
    var coach: String?
    var players: [Player]?
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: "TeamDetailsViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preseneter = TeamDetailsPresenter(view: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.sectionHeaderTopPadding = 0
        
        initSocialViews()
        preseneter.loadData(teamName: teamName ?? "", sportType: sportType ?? .football)
    }
    
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = banner.bounds
        gradient.colors = [
            UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1).cgColor,
            UIColor(red: 30/255, green: 64/255, blue: 175/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.5, y: 1.0)
        
        banner.layer.insertSublayer(gradient, at: 0)
    }
    
    func initSocialViews(){
        youtube.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(onYoutubeClick))
        youtube.addGestureRecognizer(tap1)
        
        twitter.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(onTwitterClick))
        twitter.addGestureRecognizer(tap2)
        
        facebook.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(onFacebookClick))
        facebook.addGestureRecognizer(tap3)
    }
    
    @objc func onYoutubeClick() {
        preseneter.onSocialClicked(with: SocialOption.youtube)
    }
    
    @objc func onFacebookClick() {
        preseneter.onSocialClicked(with: SocialOption.facebook)
    }
    
    @objc func onTwitterClick() {
        preseneter.onSocialClicked(with: SocialOption.twitter)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return players != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return players != nil ? "Players" : nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(players == nil){
            return nil
        }
        if(players?.isEmpty ?? true){
            return nil
        }
        
        let header = UILabel()
        header.text = "Players"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let player = players?[indexPath.row] else{
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
                
        var corners = Corners.none
        switch(indexPath.row){
            case 0: corners = Corners.top
            case (players?.count ?? 0) - 1: corners = Corners.bottom
            default: break
        }
        
        cell.config(with: player, cornerRadius: corners)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (players?.count ?? 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    func loadTeam(team: TeamDetails){
        teamImage.sd_setImage(with: URL(string: team.thumbnail ?? ""), placeholderImage: UIImage(named: "football"))

        teamNameLabel.text = team.name
        teamCoach.text = coach
        teamCountry.text = team.national
        teamFoundedDate.text = team.founded
    }
    
    func setLoading(with loading: Bool){
        loadingSection.isHidden = !loading
        
        if loading {
            loadingIndicator.startAnimating()
        }else{
            loadingIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

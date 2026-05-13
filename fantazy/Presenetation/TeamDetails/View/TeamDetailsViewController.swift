import UIKit

class TeamDetailsViewController: UIViewController, TeamDetailsViewProtocol,
                                 UITableViewDelegate, UITableViewDataSource{
    var preseneter: TeamDetailsPresenterProtocol!
    
    @IBOutlet var banner: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var facebook: UIView!
    @IBOutlet var twitter: UIView!
    @IBOutlet var youtube: UIView!
    
    @IBOutlet var teamStadium: UILabel!
    @IBOutlet var teamNationality: UILabel!
    @IBOutlet var teamFoundedDate: UILabel!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var teamImage: UIImageView!
    
    var team: Team?
    
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
        
        initSocialViews()
        preseneter.loadData()
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
        preseneter.onSocialClicked(with: "Youtube")
    }
    
    @objc func onFacebookClick() {
        preseneter.onSocialClicked(with: "Facebook")
    }
    
    @objc func onTwitterClick() {
        preseneter.onSocialClicked(with: "Twitter")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preseneter.playersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        
        cell.config(with: preseneter.getPlayer(with: indexPath.row))
        return cell
    }
    
    func loadPlayers(players: [Player]){
        tableView.reloadData()
    }
    
    func loadTeam(team: TeamDetails){
        // Test the image
        teamImage.image = UIImage(named: "basketball")
        
        //TODO: get the image using SDWebImage
        teamName.text = team.name
        teamNationality.text = team.national
        teamStadium.text = team.stadium
        teamFoundedDate.text = team.founded
    }
}

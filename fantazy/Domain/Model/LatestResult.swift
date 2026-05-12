class LatestResult{
    let homeTeamLogo: String
    let awayTeamLogo: String
    let homeTeamName: String
    let awayTeamName: String
    let result: String
    let date: String
        
    init(homeTeamLogo: String,
         awayTeamLogo: String,
         homeTeamName: String,
         awayTeamName: String,
         result: String,
         date: String){
        
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
        self.result = result
        self.date = date
    }
}

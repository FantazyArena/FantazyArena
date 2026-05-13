class AllLeaguesResponseDTO: Decodable {
    
    let leagueId: String
    let countryName: String
    let leagueLogo: String
    let leagueName: String
    
    init(leagueId: String,
          countryName: String,
          leagueLogo: String,
         leagueName: String){
        
        self.countryName = countryName
        self.leagueLogo = leagueLogo
        self.leagueName = leagueName
        self.leagueId = leagueId
    }
}

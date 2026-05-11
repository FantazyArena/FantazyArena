class LocalDataSource: LocalDataSourceProtocol {
    let leagueDao: LeagueDao
    
    init(leagueDao: LeagueDao){
        self.leagueDao = leagueDao
    }
}

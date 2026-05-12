class LocalDataSource: LocalDataSourceProtocol {
    let leagueDao: LeagueDAO
    
    init(leagueDao: LeagueDAO){
        self.leagueDao = leagueDao
    }
}

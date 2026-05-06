class SportsRepositoty: SportsRepositotyProtocol{
    
    static let shared: SportsRepositotyProtocol = SportsRepositoty(local: LocalDataSource(leagueDao: LeagueDao()), remote: RemoteDataSource())
    
    let local: LocalDataSourceProtocol
    let remote: RemoteDataSourceProtocol
    
    private init(local: LocalDataSourceProtocol, remote: RemoteDataSourceProtocol){
        self.local = local
        self.remote = remote
    }
}

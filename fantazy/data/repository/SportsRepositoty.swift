import Foundation

class SportsRepositoty: SportsRepositotyProtocol{
    
    static let shared: SportsRepositotyProtocol = SportsRepositoty(local: LocalDataSource(leagueDao: LeagueDao()), remote: RemoteDataSource())
    
    let local: LocalDataSourceProtocol
    let remote: RemoteDataSourceProtocol
    
    private init(local: LocalDataSourceProtocol, remote: RemoteDataSourceProtocol){
        self.local = local
        self.remote = remote
    }
    
    func fetchLeagues(
        sport: Sport,
        completion: @escaping (Result<[League], Error>) -> Void
    ) {

        // simulate network delay

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            let leagues = [

                League(
                    name: "Premier League",
                    badgeURL:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLFXtmUsGjZ0tqRZlxNE5jFWnI72nA108RBA&s"
                ),

                League(
                    name: "Champions League",
                    badgeURL:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVqOch7HSvCKvpY7CeQaIjgPGa1cfT_gRhdw&s"
                ),

                League(
                    name: "League Cup",
                    badgeURL:"https://www.backsportspage.com/wp-content/uploads/2022/08/2707566-55973350-2560-1440.jpg"
                )
            ]

            completion(.success(leagues))
        }
    }
}

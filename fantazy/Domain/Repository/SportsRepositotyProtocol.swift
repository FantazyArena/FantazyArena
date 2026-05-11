protocol SportsRepositotyProtocol{
    
    func fetchLeagues(
          sport: Sport,
          completion: @escaping (Result<[League], Error>) -> Void
      )
}

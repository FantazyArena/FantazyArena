import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}

    func request<T: Decodable>(
          endpoint: Endpoint,
          api: ApiType,
          model: T.Type
      ) async throws -> T {
                    
          var baseUrl = ""
          
          switch(api){
              case .football: baseUrl = ApiConfig.FOOTBALL_BASE_URL
              case .basketball: baseUrl = ApiConfig.BASKETBALL_BASE_URL
              case .footballTeam: baseUrl = ApiConfig.FOOTBALL_TEAM_BASE_URL
            case .basketballTeam: baseUrl = ApiConfig.FOOTBALL_TEAM_BASE_URL
          }
          
          let url = baseUrl + endpoint.path
          return try await withCheckedThrowingContinuation { continuation in
              
              AF.request(
                  url,
                  parameters: endpoint.parameters
              )
              .validate()
              .responseDecodable(of: T.self) { response in
                  
                  switch response.result {
                  case .success(let data):
                      continuation.resume(returning: data)
                      
                  case .failure(let error):
                      continuation.resume(throwing: error)
                  }
              }
          }
      }
}

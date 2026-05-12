import Alamofire

class AllLeaguesEndpoint: Endpoint {
       
    var path: String { "" }
    
    var parameters: Parameters {
        [
            "met": "Leagues",
            "APIkey": ApiConfig.SPORTS_API_KEY
        ]
    }
}

import Foundation

class ApiConfig {
    
    static let FOOTBALL_BASE_URL = "https://apiv2.allsportsapi.com/football/"
    static let BASKETBALL_BASE_URL = "https://apiv2.allsportsapi.com/basketball/"
    
    static let FOOTBALL_TEAM_BASE_URL = ""
    static let BASKETBALL_TEAM_BASE_URL = ""
    
    static var SPORTS_API_KEY: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "SPORTS_API_KEY") as? String else {
            fatalError("SPORTS_API_KEY not found in Info.plist")
        }
        
        return key
    }
    
    static var TEAM_API_KEY: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "TEAM_API_KEY") as? String else {
            fatalError("TEAM_API_KEY not found in Info.plist")
        }
        
        return key
    }

    private init() {  }
}

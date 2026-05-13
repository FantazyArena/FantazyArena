import Foundation

enum SportType {
    case football
    case basketball

    var service: SportService {
        switch self {
        case .football:    return FootballAPIService.shared
        case .basketball:  return BasketballAPIService.shared
        }
    }
}

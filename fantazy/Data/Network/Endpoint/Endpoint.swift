import Alamofire

protocol Endpoint {
    var path: String { get }
    var parameters: Parameters { get }
}

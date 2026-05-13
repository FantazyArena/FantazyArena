import Foundation

struct APISportsResponseDTO<T: Decodable>: Decodable {
    let results: Int
    let response: [T]?
}

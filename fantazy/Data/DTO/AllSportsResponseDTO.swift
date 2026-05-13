import Foundation

struct AllSportsResponseDTO<T: Decodable>: Decodable {
    let success: Int
    let result: [T]?
}

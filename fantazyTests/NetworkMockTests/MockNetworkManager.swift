//
//  MockNetworkManager.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import XCTest
@testable import fantazy

class MockNetworkManager: NetworkManagerProtocol {

    var mockResult: Any?
    var mockError: Error?
    var lastEndpoint: Endpoint?
    var lastApi: ApiType?

    func request<T: Decodable>(
        endpoint: Endpoint,
        api: ApiType,
        model: T.Type
    ) async throws -> T {
        lastEndpoint = endpoint
        lastApi = api

        if let error = mockError {
            throw error
        }
        if let result = mockResult as? T {
            return result
        }
        throw NSError(domain: "MockError", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "No mock data set"])
    }
}

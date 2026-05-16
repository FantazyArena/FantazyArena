//
//  XCTestCase.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import XCTest
import Alamofire

extension XCTestCase {

    func makeMockSession() -> Session {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return Session(configuration: config)
    }

    func mockResponse(json: String, statusCode: Int = 200) {
        MockURLProtocol.mockData = json.data(using: .utf8)
        MockURLProtocol.mockStatusCode = statusCode
    }

    func mockError(_ error: Error) {
        MockURLProtocol.mockError = error
    }
}

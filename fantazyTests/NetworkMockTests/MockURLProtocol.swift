//
//  MockURLProtocol.swift
//  fantazyTests
//
//  Created by Ahmed El Sayyad Mohamed on 15/05/2026.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var mockData: Data?
    static var mockError: Error?
    static var mockStatusCode: Int = 200

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let data = MockURLProtocol.mockData {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.mockStatusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    static func reset() {
        mockData = nil
        mockError = nil
        mockStatusCode = 200
    }
}

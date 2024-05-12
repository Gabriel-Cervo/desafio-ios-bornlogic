//
//  NewsRepositoryTests.swift
//  bornlogic-testTests
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import XCTest
@testable import bornlogic_test

final class NewsRepositoryTests: XCTestCase {
    
    var urlSession: URLSession!
    var service: NetworkServiceProtocol!
    var sut: NewsRepositoryProtocol!
    var route: Router!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        service = DefaultNetworkService(urlSession: urlSession)
        route = NewsRoute.fetchNews(page: 1)
        sut = DefaultNewsRepository(networkService: service)
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        urlSession = nil
        service = nil
        sut = nil
        route = nil
        
        try super.tearDownWithError()
    }

    func testFetchSuccess() throws {
        let response = HTTPURLResponse(
         url: try! route.asURLRequest().url!,
         statusCode: 200,
         httpVersion: nil,
         headerFields: route.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockNewsListData)
        }
        
        let expectation = XCTestExpectation(description: "fetch news success")
    
        sut.executeLoad(page: 1) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.totalResults, mockNewsList.totalResults)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchError() throws {
        let response = HTTPURLResponse(
         url: try! route.asURLRequest().url!,
         statusCode: 402,
         httpVersion: nil,
         headerFields: route.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockNewsListData)
        }
        
        let expectation = XCTestExpectation(description: "fetch list error")
        
        sut.executeLoad(page: 1) { result in
            switch result {
            case .success(_):
                XCTFail("It should not be success")
            case .failure(let failure):
                XCTAssertEqual(NetworkError.requestFailed(statusCode: 402).localizedDescription, failure.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

}

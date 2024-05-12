//
//  NewsViewModleTests.swift
//  bornlogic-testTests
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import XCTest
@testable import bornlogic_test

final class NewsViewModleTests: XCTestCase {
    func testSuccessFetchData() throws {
        let useCase = SuccessMockExtractUseCase()
        let sut = DefaultNewsViewModel(fetchDataUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data success")
        
        sut.onFetchError = { error in
            XCTAssertThrowsError(error)
        }
        
        sut.onFetchSuccess = { data in
            XCTAssertEqual(data.totalResults, mockNewsList.totalResults)
            expectation.fulfill()
        }
        
        sut.fetchData(forPage: 1)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFailureFetchData() throws {
        let useCase = FailureMockExtractUseCase()
        let sut = DefaultNewsViewModel(fetchDataUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.onFetchError = { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.requestFailed(statusCode: 401).localizedDescription)
            expectation.fulfill()
        }
        
        sut.onFetchSuccess = { _ in
            XCTFail("It should not be a success")
        }
        
        sut.fetchData(forPage: 1)
        
        wait(for: [expectation], timeout: 5)
    }

}

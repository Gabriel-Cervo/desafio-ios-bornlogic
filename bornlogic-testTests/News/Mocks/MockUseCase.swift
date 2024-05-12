//
//  MockUseCase.swift
//  bornlogic-testTests
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation
@testable import bornlogic_test

struct SuccessMockExtractUseCase: LoadNewsUseCase {
    func run(page: Int, completionHandler: @escaping (Result<NewsList, NetworkError>) -> Void) {
        completionHandler(.success(mockNewsList))
    }
}

struct FailureMockExtractUseCase: LoadNewsUseCase {
    func run(page: Int, completionHandler: @escaping (Result<NewsList, NetworkError>) -> Void) {
        completionHandler(.failure(.requestFailed(statusCode: 401)))
    }
}

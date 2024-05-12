//
//  DefaultNewsRepository.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

final class DefaultNewsRepository: NewsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func executeLoad(page: Int, completionHandler: @escaping ((Result<NewsList, NetworkError>) -> Void)) {
        do {
            try networkService.request(NewsList.self, router: NewsRoute.fetchNews(page: page), completionHandler: completionHandler)
        } catch {
            completionHandler(.failure(.generic(error: error)))
        }
    }
}

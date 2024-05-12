//
//  LoadNewsUseCase.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

//MARK: - protocol

protocol LoadNewsUseCase {
    func run(page: Int, completionHandler: @escaping (Result<NewsList, NetworkError>) -> Void)
}

//MARK: - default implementation

final class DefaultLoadNewsUseCase: LoadNewsUseCase {
    private let repository: NewsRepositoryProtocol
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func run(page: Int, completionHandler: @escaping (Result<NewsList, NetworkError>) -> Void) {
        repository.executeLoad(page: page, completionHandler: completionHandler)
    }
}


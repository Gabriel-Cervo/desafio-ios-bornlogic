//
//  DefaultNewsViewModel.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

final class DefaultNewsViewModel: NewsViewModelProtocol {
    private let fetchDataUseCase: LoadNewsUseCase
    
    var news: NewsList?
    var onFetchSuccess: ((NewsList) -> Void)?
    var onFetchError: ((Error) -> Void)?
    
    init(fetchDataUseCase: LoadNewsUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
    }
    
    func fetchData(forPage page: Int) {
        fetchDataUseCase.run(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                self?.news = data
                self?.onFetchSuccess?(data)
            case .failure(let error):
                self?.onFetchError?(error)
            }
        }
    }
}

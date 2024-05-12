//
//  NewsViewModelProtocol.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

protocol NewsViewModelInput: AnyObject {
    func fetchData(forPage page: Int)
}

protocol NewsViewModelOutput: AnyObject {
    var onFetchSuccess: ((NewsList) -> Void)? { get set }
    var onFetchError: ((Error) -> Void)? { get set }
}

protocol NewsViewModelProtocol: NewsViewModelInput & NewsViewModelOutput {
    var news: NewsList? { get set }
}

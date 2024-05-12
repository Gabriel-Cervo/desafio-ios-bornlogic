//
//  NewsRepositoryProtocol.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

protocol NewsRepositoryProtocol {
    func executeLoad(page: Int, completionHandler: @escaping ((Result<NewsList, NetworkError>) -> Void))
}

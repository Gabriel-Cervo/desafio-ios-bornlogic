//
//  Constants.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import Foundation

struct Constants {
    private init() {}
     
    /// Tag used to identify shimmering block in a view
    static let shimmeringBlockTag = 987
    
    static let newsApiService = "newsAPI"
    static let newsApiAccount = "teste-news-api"
    static let defaultRequestHeaders: RequestHeader = ["Content-Type": "application/json"]
    
    static let defaultPadding: CGFloat = 16.0
}

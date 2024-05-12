//
//  NewsRoute.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

enum NewsRoute: Router {
    case fetchNews(page: Int)
    
    var baseUri: String {
        return "https://newsapi.org/v2"
    }
    
    var endpoint: String {
        return "top-headlines"
    }
     
    var method: RequestMethod {
        return .get
    }
    
    var headers: RequestHeader {
        return [:]
    }
    
    var queryItems: RequestHeader {
        switch self {
        case .fetchNews(let page):
            return [
                "country": "us",
                "page": "\(page)",
                "pageSize": "10",
            ]
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}

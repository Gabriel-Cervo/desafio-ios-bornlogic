//
//  NetworkMockRoute.swift
//  bornlogic-testTests
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation
@testable import bornlogic_test

enum NetworkMockRoute: Router {
    case catSearch
    
    var baseUri: String { "https://api.thecatapi.com" }
    var endpoint: String { "v1/images/search" }
    var method: RequestMethod { .get }
    var headers: RequestHeader { ["Content-Type": "application/json"] }
    var queryItems: RequestHeader { [:]}
    var parameters: [String: Any]? { nil }
}

//MARK: - cat struct

struct CatModel: Codable {
    var id: String?
    var url: String?
}

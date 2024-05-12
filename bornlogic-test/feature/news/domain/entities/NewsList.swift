//
//  NewsList.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

struct NewsList: Codable {
    @DefaultInt var totalResults: Int
    @DefaultEmptyArray var articles: [NewsArticle]
}

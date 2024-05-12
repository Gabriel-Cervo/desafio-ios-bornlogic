//
//  MockNews.swift
//  bornlogic-testTests
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation
@testable import bornlogic_test

let mockNewsList = NewsList(totalResults: 1, articles: [
    .init(source: .init(name: "wired"), author: "Ryan Waniata", title: "Beats Solo 4 Review: Minimal Features, Maximized Sound", description: "Beats’ latest on-ear headphones lack noise canceling and auto pause, but they sound fantastic.", urlToImage: "https://media.wired.com/photos/663e62b002abb3853e7a7352/191:100/w_120,c_limit/Beats-Solo-4-Headphones-collage-052024-SOURCE-Ryan-Waniata.jpg", publishedAt: "2024-05-11T13:00:00Z", content: "Theres not much to the new Beats Solo 4 headphones at first glance. Starkly missing in this $200 package is any form of noise canceling or transparency mode. Theres no auto pause feature or water-res… [+3450 chars]")
    ]
)

var mockNewsListData: Data {
    return try! JSONEncoder().encode(mockNewsList)
}

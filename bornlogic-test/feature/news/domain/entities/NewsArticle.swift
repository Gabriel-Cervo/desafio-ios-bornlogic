//
//  NewsArticle.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

/**
 Details of a news
 
 Example model from the api:
 ```
 {
     "source": {
     "id": "the-verge",
     "name": "The Verge"
     },
     "author": "Victoria Song",
     "title": "The Garmin Lily 2 was the tracker I needed on vacation",
     "description": "The $249.99 Garmin Lily 2 is a simple yet chic hybrid analog tracker that’s best suited for casual users.",
     "url": "https://www.theverge.com/24152258/garmin-lily-2-fitness-tracker-wearable-smartwatch",
     "urlToImage": "https://cdn.vox-cdn.com/thumbor/DVrGPWvtoneyi__UEZ1SA4jlNCQ=/0x0:2700x1800/1200x628/filters:focal(809x968:810x969)/cdn.vox-cdn.com/uploads/chorus_asset/file/25289831/247019_Garmin_Lily_2_AKrales_0014.jpg",
     "publishedAt": "2024-05-11T13:00:00Z",
     "content": "Its limitations made it fall short in daily life but ended up being a plus while trying to disconnect from the world.\r\nByVictoria Song, a senior reporter focusing on wearables, health tech, and more … [+5412 chars]"
 }
 ```

 */
struct NewsArticle: Codable {
    let source: NewsDetailsSource?
    
    @DefaultString var author: String
    @DefaultString var title: String
    @DefaultString var description: String
    @DefaultString var url: String
    @DefaultString var urlToImage: String
    @DefaultString var publishedAt: String
    @DefaultString var content: String
}

struct NewsDetailsSource: Codable {
    @DefaultString var name: String
}

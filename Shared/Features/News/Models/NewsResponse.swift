//
//  NewsResponse.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

import Foundation

// Create structure for NewsResponse of type Codable
struct NewsResponse: Codable {
    
    var articles: [News]  // array of articles (News) of type string which we are returning
}

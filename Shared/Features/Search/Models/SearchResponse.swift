//
//  SearchResponse.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/28/22.
//

import Foundation

// structure SearchReponse of type Codable
struct SearchResponse: Codable {
    
    // the key that is returned (call Search)
    var bestMatches: [Search]
}

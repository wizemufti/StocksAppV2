//
//  Search.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/28/22.
//

// Model for the Search

import Foundation

// structure Search of type codable and identifiable
struct Search: Codable, Identifiable {
    
    var id: UUID { return UUID() }
    var symbol: String
    var name: String
    var type: String
    
    // initialize variables with cases
    private enum CodingKeys: String, CodingKey {
        
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
    }
}

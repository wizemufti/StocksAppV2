//
//  Quote.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// All the information stored in the Quote API
// https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo

import Foundation

// structure for Quote which takes in codable
struct Quote: Codable {
    
    // declaring the variables from inside of the API on alphaVantage for Global Quotes
    var symbol: String
    var open: String
    var close: String
    var low: String
    var price: String
    var change: String
    var changePercent: String
    
    // private method called CodingKeys of type String w/ CodingKey protocal
    private enum CodingKeys: String, CodingKey {
        
        // cases for each of the variables
        case symbol = "01. symbol"
        case open = "02. open"
        case close = "03, high"
        case low = "04. low"
        case price = "05. price"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
    
}

extension Quote: Identifiable {
    var id: UUID {
        return UUID()
    }
}

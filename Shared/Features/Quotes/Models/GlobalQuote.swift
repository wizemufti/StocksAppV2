//
//  GlobalQuote.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// Quote Models

import Foundation

// structure GlobalQuoteResponse which takes in codable (for encoding and decoding)
struct GlobalQuoteResponse: Codable {
    
    // variable quote of type Quote (refers to Quote structure)
    var quote: Quote
    
    
    // private method (not accessible to everything) called CodingKeys of type String w/ CodingKey protocal
    private enum CodingKeys: String, CodingKey {
        
        // our case called quote represented inside of the JSON as Global Quote
        // whatever we get inside of the JSON for quote will be mapped to Global Quote
        case quote = "Global Quote"
    }
}



//
//  MockQuoteManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// Mock Quote Manager
// 

import Foundation


// class MockQuoteManager for our mock downloads of quotes
final class MockQuoteManager: QuoteManagerProtocol, ObservableObject {
   
    // variable quotes that holds array of the quotes
    @Published var quotes: [Quote] = []
    
    // function for downloading the quotes
    func download(stocks: [String], completion: @escaping (Result<[Quote], NetworkError>) -> Void) {
        
        // sample data
        // in tutorial, they used high instead of close but it gives an error
        let aapl = Quote(symbol: "AAPL", open: "135.90", close: "136.90", low: "133.77", price: "135.13", change: "-0.26", changePercent: "-0.19%")
        let goog = Quote(symbol: "GOOG", open: "2099.51", close: "2102.03", low: "2077.32", price: "2095.89", change: "0.51", changePercent: "0.024%")
        
        
        // for loop to give us our mock data with multiple brackets
        for _ in 0..<8 {
            quotes.append(contentsOf: [aapl, goog])
        }
    }
}

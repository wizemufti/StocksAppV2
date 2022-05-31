//
//  QuoteManagerProtocol.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// Quote manager protocol which holds quotes

import Foundation

// protocol for managing the quotes
protocol QuoteManagerProtocol {
    
    // variable quotes which holds an array of quotes
    var quotes: [Quote] { get set }
    
    // function for downloading the quotes
    // the stock is stored as an array of strings
    // an array of quotes and NetworkError is passed into Result
    func download(stocks: [String], completion: @escaping (Result<[Quote], NetworkError>) -> Void)
}


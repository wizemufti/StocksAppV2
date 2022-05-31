//
//  API.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// Quotes API Helper
// Keep all of our API stuff in here
// https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo
// https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=tesco&apikey=demo

import Foundation

// Structure which provides base URL, symbols, search, quote, and etc. for the API
struct API {
    
    // creating variable of type string for our baseURL. Returns the URL that all the API calls have in common
    static var baseUrl: String {
        
        // base URL for all the API calls
        return "https://www.alphavantage.co/query?"
    }
    
    // function called symbolSearchURL for search key which takes in a string and returns type string
    static func symbolSearchUrl(for searchKey: String) -> String {
        
        // return the symbol search by calling urlBy function
        return urlBy(symbol: .search, searchKey: searchKey)
    }
    
    // function called quoteUrl for serachkey which takes in a string and returns type string
    static func quoteUrl(for searchKey: String) -> String {
        
        // return the global quote by calling the urlBy function
        return urlBy(symbol: .quote, searchKey: searchKey)
    }
    
    // function for getting the information from symbol search and global quote
    private static func urlBy(symbol: SymbolFunction, searchKey: String) -> String {
        
        // switch statement
        switch symbol {
            
        // return the baseURL along with the Symbol Search function after it (specific API call)
        case .search:
            return "\(baseUrl)function=\(symbol.rawValue)&apikey=\(key)&keywords=\(searchKey)"
            
        // return the baseURL along with the Global Quote function after it (specific API call)
        case .quote:
            return "\(baseUrl)function=\(symbol.rawValue)&apikey=\(key)&symbol=\(searchKey)"
            
        }
    }
    
    // define the different functions from alphaVantage
    enum SymbolFunction: String {
        
        // case for symbol search and global quote. These are API parameters
        case search = "SYMBOL_SEARCH"
        case quote = "GLOBAL_QUOTE"
    }
}

// Stores our API key
extension API {
    static var key: String {
        
        // return my unique API key for alphaVantage
        return "I9YJNWBYAESK10UK"
    }
}

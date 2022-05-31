//
//  StockQuoteManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/13/22.
//

// Stock Quote Manager
// This will implement the manager. Will call the Network Manager API

import Foundation


final class StockQuoteManager: QuoteManagerProtocol, ObservableObject {
    
    @Published var quotes: [Quote] = []
    
    func download(stocks: [String], completion: @escaping (Result<[Quote], NetworkError>) -> Void) {
        
        // Create variable for quote. Keeps the quotes value
        var internalQuotes = [Quote]()
        
        
        let downloadQueue = DispatchQueue(label: "com.devtechie.downloadQueue")
        let downloadGroup = DispatchGroup()
        
        
        // take the stocks where forEach takes in the individual stocks
        stocks.forEach { (stock) in
            
            downloadGroup.enter()                               // indicate we are entering the group so download is being performed
            let url = URL(string: API.quoteUrl(for: stock))!    // construct url of the stock
            
            // call NetworkManager and fetch from the url
            NetworkManager<GlobalQuoteResponse>().fetch(from: url) { (result) in
                
                // switch statement
                switch result {
                    
                // for cases that fail, print the error, then leave
                case.failure(let err):
                    print(err)
                    downloadQueue.async {
                        downloadGroup.leave()
                    }
                    
                // for cases that have success, append to the internalQuotes then leave
                case.success(let resp):
                    downloadQueue.async {
                        internalQuotes.append(resp.quote)
                        downloadGroup.leave()
                    }
                }
            }
        }
        
        // once the downloads are complete, get downloadGroup and notify  the global queue
        downloadGroup.notify(queue: DispatchQueue.global()) {
            
            // provide the internalQuotes that were successful
            completion(.success(internalQuotes))
            
            // call DispatchQueue, then call quotes and append the contents of internalQuotes
            DispatchQueue.main.async {
                self.quotes.append(contentsOf: internalQuotes)
            }
        }
    }
    
    
    
}

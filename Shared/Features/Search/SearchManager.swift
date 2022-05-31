//
//  SearchManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/28/22.
//

import Foundation

final class SearchManager: ObservableObject {
    
    @Published var searches = [Search]()
    
    func searchStocks(keyword: String) {
        
        NetworkManager<SearchResponse>().fetch(from: URL(string: API.symbolSearchUrl(for: keyword))!) { (result) in
            
            // switch statement to determine result
            switch result {
                
            // if search fetch fails, then print the error
            case.failure(let err):
                print(err)
                
            // if search fetch succeeds, then display all of the search results
            case.success(let resp):
                DispatchQueue.main.async {
                    self.searches = resp.bestMatches
                }
            }
        }
    }
}

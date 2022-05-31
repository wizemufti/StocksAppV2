//
//  NewsDownloadManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

// Download manager for NewsAPI

import Foundation

// class for download manager
final class NewsDownloadManager: ObservableObject {
    
    @Published var newsArticles = [News]()

    // For getting the top headline of the news article
    private let newsUrlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(NewsAPI.key)"
    
    // https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
    
    init() {
        // call download function
        download()
    }

    // function to download
    func download() {
        
        // Get URL info using NetworkManager from NewsResponse
        NetworkManager<NewsResponse>().fetch(from: URL(string: newsUrlString)!) { (result) in
           
            // switch statement to show result
            switch result {
                
            // if the fetch fails, print the error
            case .failure(let err):
                print (err)
            
            // if the fetch is successful, get response from article
            case .success(let resp):
                DispatchQueue.main.async {
                    self.newsArticles = resp.articles
                }
            }
        }
    }
}

//
//  MockNewsDownloadManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/27/22.
//

import Foundation


final class MockNewsDownloadManager: ObservableObject {
    
    @Published var newsArticles = [News]()
    
    // For getting the top headline of the news article
    private let newsUrlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(NewsAPI.key)"
    
    
    func download(articles: [String], completion: @escaping (Result<[News], NetworkError>) -> Void) {
        
        let NA = News(title: "bla", url: "blabla", urlToImage: "blablabla")
        
        
        for _ in 0..<8 {
            newsArticles.append(contentsOf: [NA])
        }
    }
}

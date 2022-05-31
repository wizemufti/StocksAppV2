//
//  News.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

import Foundation

// structure news of type identifiable and codable
struct News: Identifiable, Codable {
    
    // variable ID which helps track our list for each case. Each article can be identified individually
    var id: UUID { return UUID()}
    
    // variables needed for each news articles
    var title: String
    var url: String
    var urlToImage: String?     // optional string since urlToImage does not always apply (look at next line of code)
    
    // actual imageUrl used in our app
    var imageUrl: String {
        
        // replace http w/ https whenever http is used since we want to output articles from all URL types
        return urlToImage?.replacingOccurrences(of: "http://", with: "https://") ??
        
        // sample news image to output (for testing purposes)
        "https://archive.org/download/sky-news-logo/sky-news-logo.jpg"
    }
}


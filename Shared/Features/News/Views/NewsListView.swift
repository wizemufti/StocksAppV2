//
//  NewsListView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

// Shows view of all the news articles

import SwiftUI
import BetterSafariView         // import safari view package we added

struct NewsListView: View {
    
    //@ObservedObject var newsManager: MockNewsDownloadManager
    @ObservedObject var newsManager: NewsDownloadManager
    @State private var showOnSafari = false
    
    // get state of the article = (optional)
    @State private var selectedArticle: News?
    
    var body: some View {
        
        VStack {
            
            // allows scrolling through list
            ScrollView(.vertical, showsIndicators: false) {
                
                // for each of the news articles from the manager, put the article in
                ForEach(newsManager.newsArticles) { article in
                    
                    // create layout for news articles
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            Text(article.title)         // display the title of each article
                                .bold()
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)       // can move up and down but not left and right
                            
                            // seperator
                            Spacer()
                            
                            // call Async image
                            AsyncImage.init(url: URL(string: article.imageUrl)!) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.2))
                            } image: { (img) -> Image in
                                Image(uiImage: img)
                                    .resizable()
                            }
                            .scaledToFill()
                            .frame(width: 100, height: 160)
                            .cornerRadius(10)

                            
                        }
                        .contentShape(Rectangle())
                        
                            // when tapped
                            .onTapGesture {
                                selectedArticle = article
                                showOnSafari.toggle()
                            }
                            .sheet(isPresented: $showOnSafari, content: {
                                
                                // call loadNews to get selectedArticle otherwise take the article
                                loadNews(for: selectedArticle ?? article)
                            })
                        
                        // divider
                        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2))
                            .padding(.horizontal, 50)
                            .frame(height: 1)
                    }
                }
            }
        }
    }
    
    // loadNews functio0n
    private func loadNews(for article: News) -> some View {
        
        // safari view handles authentication
        // also replace occurences like before to include all URLs
        return SafariView(url: URL(string: article.url.replacingOccurrences(of: "http://", with: "https://"))!)
    }
}

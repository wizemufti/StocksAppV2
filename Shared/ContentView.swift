//
//  ContentView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/14/22.
//

// Main class - Where all of our project files tie in and everything is run through

// Note - If the following errors sometimes occurs: (Zscaler issue)
    // "An SSL error has occurred and a secure connection to the server cannot be made."
// Ignore as this is due to the connectivity from the other side of the API (moderators runnning the API). Therefore, Mock functions are being used to display data (as reference)

import SwiftUI

// Structure for ContentView of type View (create view, show screen)
struct ContentView: View {
    
    //@ObservedObject var stockManager = StockQuoteManager()
    //@ObservedObject var stockManager = MockNewsDownloadManager()
    
    // ObservedObject reference for our 2 API's - News and Quotes
    @ObservedObject var stockManager = MockQuoteManager()
    @ObservedObject var newsManager = NewsDownloadManager()
    
    // Variables needed for our API's
    //@State private var stocks = UserDefaultsManager.shared.savedSymbols
    @State private var stocks = ["AAPL", "GOOG"]
    @State private var searchTerm = ""
    @State private var newsOpen = false
    @State private var oldStocks = [String]()
    
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    // View method (content is displayed through here onto screen)
    var body: some View {
        
        // Create zStack
        ZStack {
            
            // background color
            Color.black
            
            // Create vStack
            VStack(alignment: .leading) {
                
                // if user opens the news tab
                if newsOpen {
                    withAnimation {
                        
                        // call MiniQuoteView function w/ reference to stockManager
                        MiniQuoteView(stockQuotes: stockManager)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 100 : 0)
                            .transition(.move(edge: .top))
                    }
                }
                
                // if user does not open the news tab
                else {
                    withAnimation {
                        
                        // call HeaderView function w/ reference to stocks
                        HeaderView(stocks: $stocks)
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 0 : 100)
                            .transition(.move(edge: .top))
                    }
                }
                
                // For creating list view
                List {
                    
                    // For creating grouping
                    Group {
                        // call SearchTextView function
                        SearchTextView(searchTerm: $searchTerm)
                        
                        // Call getQuotes() function for each reference then output the quotes in a list by calling QuoteCell()
                        ForEach(getQuotes()) { quote in
                            QuoteCell(quote: quote)
                        }
                    }
                    
                    // modifications
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                // reinitializations
                .onAppear {
                    fetchData(for: stocks)
                    oldStocks = stocks
                }
                
                .onChange(of: stocks, perform: { value in
//                    fetchData(for: stocks.difference(from: oldStocks))
//                    oldStocks = stocks
                })
                // list modifications
                .listStyle(PlainListStyle())
                .foregroundColor(.white)
            }
            // modifications
            .padding(.horizontal, 32)
            .padding(.bottom, UIScreen.main.bounds.height * 0.21)
            
            // call NewsSheetView() function to display all the news headlines
            NewsSheetView(newsOpen: $newsOpen, newsManager: newsManager)
            
        }
        // show on whole screen
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getQuotes() -> [Quote] {
        return searchTerm.isEmpty ? stockManager.quotes : stockManager.quotes.filter { $0.symbol.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private func fetchData(for symbols: [String]) {
        stockManager.download(stocks: symbols) { _ in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

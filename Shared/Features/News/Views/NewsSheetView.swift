//
//  NewsSheetView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

// Contains news header view and list view

import SwiftUI

struct NewsSheetView: View {
    
    // get state to see if news is open or not
    @Binding var newsOpen: Bool
    
    // use to display on the sheet and trigger quote view
    @ObservedObject var newsManager: NewsDownloadManager
    
    //@ObservedObject var newsManager: MockNewsDownloadManager
    
    // initializer for newsOpen
    init(newsOpen: Binding<Bool>, newsManager: NewsDownloadManager) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor  = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self._newsOpen = newsOpen
        self.newsManager = newsManager
    }
    
    var body: some View {
        
        BottomSheetView(isOpen: $newsOpen, maxHeight: UIScreen.main.bounds.height * 0.89) {
            
            ZStack {
                Color.white
                Rectangle().fill(Color.black.opacity(0.8))
                
                VStack(alignment: .leading) {
                    
                    // header view
                    NewsHeaderView()
                    
                    Spacer()
                    
                    // list view
                    NewsListView(newsManager: newsManager)
                }.padding()
            }
        }.edgesIgnoringSafeArea(.vertical)
    }
}

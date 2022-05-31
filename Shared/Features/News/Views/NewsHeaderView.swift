//
//  NewsHeaderView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

// header view for news

import SwiftUI

struct NewsHeaderView: View {
    var body: some View {
        
        // create vertical stack
        VStack(alignment: .leading) {
            
            // text for header with modifications
            Text("TOP NEWS")
                .font(.title)
                .foregroundColor(.white)
            
            // create horizontal stack
            HStack(spacing: 2) {
                
                // text to go across in the header
                Text("FROM")
                Image(systemName: "applelogo")
                Text("NewsAPI")
            }
            // text modifications
            .font(.title2)
            .foregroundColor(.gray)
            
            // separator
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray)
                .frame(height: 1)
            
        }
    }
}

struct NewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NewsHeaderView()
    }
}

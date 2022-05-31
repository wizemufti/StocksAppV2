//
//  SearchTextView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/14/22.
//

import SwiftUI

struct SearchTextView: View {
    
    @Binding var searchTerm: String
    
    var body: some View {
        
        // custom text field for search bar with a bunch of customizations
        CustomTextField(placeHolder:
                            Text("Search").foregroundColor(Color.gray), text: $searchTerm)
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                            .frame(height: 30)
                            .background(ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.6))
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.gray)
                                    .padding(.leading, 10)
                            })
    }
}

struct SearchTextView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextView(searchTerm: .constant(""))
    }
}

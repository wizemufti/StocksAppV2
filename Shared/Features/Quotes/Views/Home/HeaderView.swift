//
//  HeaderView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/14/22.
//

// Creates the HeaderView for our project (first view we see when app opens)

import SwiftUI

struct HeaderView: View {
    
    // private variable dateFormatter
    // converts between dates and textual representation
    private let dateFormatter: DateFormatter = {
       
        // declare variable for outputting date
        let formatter = DateFormatter()
        
        // output date in the following format and return it
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
    
    @Binding var stocks: [String]       // Create binding for stocks, held in an array as a string
    
    @State private var showSearch = false      // Keeps track of search
    
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: -5) {
                
                // Output stocks title
                Text("Stocks")
                    .foregroundColor(.white)
                    .bold()
                
                // Output date from dateFormatter
                Text("\(Date(), formatter: dateFormatter)")
                    .foregroundColor(.gray)
                    .bold()
                
            }
            .font(.title)   // All fonts set to title
            Spacer()        // Spacer to divide stuff
            
            Button {
                // Toggles the showSearch which will help us launch the sheet that displays the search bar
                showSearch.toggle()
            } label: {
                
                // Insert image
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            // Attach a sheet
            .sheet(isPresented: $showSearch, onDismiss: {
                
                self.stocks = UserDefaultsManager.shared.savedSymbols
                
            }, content: {
                //Text("Search view goes here")
                SearchView()        // call SearchView to display search bar for stocks
            })
        
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(stocks: .constant(["AAPL", "GOOG"]))
    }
}

//
//  QuoteCell.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/14/22.
//

import SwiftUI

struct QuoteCell: View {
    
    var quote: Quote
    
    
    var body: some View {
        
        // Horizontal stack
        HStack {
            
            // Output the quote's symbol
            Text(quote.symbol)
                .font(.body)         // font type
                .bold()
            
            // Creat space between stacks
            Spacer()
            Spacer()
            
            // Vertical stack
            VStack {
                
                // Output the quote's price
                Text(quote.price)
                    .bold()
                
                // Output the quote's change
                Text(quote.change)
                    .padding(.horizontal)
                    .frame(width: 100)
                
                    // background formatting
                    // Rectangle will be filled with green if the change is positive.
                    // Rectangle will be filled with red if the change is negative
                    .background(RoundedRectangle(cornerRadius: 5).fill(Double(quote.change)! > 0.0 ? Color.green : Color.red), alignment: .trailing)
            }
        }
    }
}

struct QuoteCell_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // pass in information
        QuoteCell(quote: Quote(symbol: "AAPL", open: "135.22", close: "140.22", low: "130.21", price: "135.12", change: "-0.12", changePercent: "0.098%"))
    }
}

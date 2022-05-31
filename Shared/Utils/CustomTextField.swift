//
//  CustomTextField.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/14/22.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeHolder: Text
    
    @Binding var text: String
    
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = {}
    
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            // if text is empty, then show the placeHolder
            if text.isEmpty { placeHolder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}


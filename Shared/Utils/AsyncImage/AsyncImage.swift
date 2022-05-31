//
//  AsyncImage.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/27/22.
//

// image view

import SwiftUI

struct AsyncImage<PlaceholderView: View>: View {
    
    @StateObject private var loader: ImageLoader
    
    private let placeholder: PlaceholderView
    private let image: (UIImage) -> Image
    
    init(url: URL, @ViewBuilder placeholder: () -> PlaceholderView, @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    private var content: some View {
        Group {
            // if loader image is not empty
            if loader.image != nil {
                
                // then get the loaded image
                image(loader.image!)
            }
            // otherwise, return placeholder
            else {
                placeholder
            }
        }
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
}




//
//  ImageCacheKey.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/27/22.
//

// components for image cache

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue}
    }
}

//
//  ImageCache.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/27/22.
//

import Foundation
import UIKit

protocol ImageCache {
    
    // create subscript for url which returns an optional UIImage. Also add getter and setter roles to this
    subscript(_ url: URL) -> UIImage? {get set}
}

struct TemporaryImageCache: ImageCache {
    
    // create the cache from NSCache
    private let cache: NSCache<NSURL, UIImage> = {
        
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100                                     // cache count limit to 100 items
        cache.totalCostLimit = 1024 * 1024 * 100                 // cache total cost limit to 100mb
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get {cache.object(forKey: key as NSURL) }
        set {newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}


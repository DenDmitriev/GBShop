//
//  TemporaryImageCache.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import Foundation
import UIKit.UIImage

protocol ImageCache {
    subscript(_ key: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100 // 100 items
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    subscript(key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            if let newValue = newValue {
                cache.setObject(newValue, forKey: key as NSURL)
            } else {
                cache.removeObject(forKey: key as NSURL)
            }
        }
    }
}

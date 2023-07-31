//
//  EnvironmentValues.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import SwiftUI

extension EnvironmentValues {
    var imageCache: ImageCache {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
}

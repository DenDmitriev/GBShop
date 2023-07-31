//
//  ImageCacheKey.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

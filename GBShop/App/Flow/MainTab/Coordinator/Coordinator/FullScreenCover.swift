//
//  FullScreenCover.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

enum FullScreenCover: String, Identifiable {
    case promo
    
    var id: String {
        self.rawValue
    }
}

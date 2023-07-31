//
//  BasketPage.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import Foundation

enum BasketPage: String, Identifiable {
    case basket
    
    var id: String {
        self.rawValue
    }
}

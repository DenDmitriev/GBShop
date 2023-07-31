//
//  CatalogPage.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

enum CatalogPage: String, Identifiable {
    case catalog
    
    var id: String {
        self.rawValue
    }
}

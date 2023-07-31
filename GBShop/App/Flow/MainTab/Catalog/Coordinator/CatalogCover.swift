//
//  CatalogCover.swift
//  GBShop
//
//  Created by Denis Dmitriev on 27.07.2023.
//

import Foundation

enum CatalogCover: String, Identifiable {
    case empty
    
    var id: String {
        self.rawValue
    }
}

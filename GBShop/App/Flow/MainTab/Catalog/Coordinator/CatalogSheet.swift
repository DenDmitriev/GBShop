//
//  CatalogSheet.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation
import SwiftUI

enum CatalogSheet: Identifiable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        return nil
    }
    
    case product(product: Product)
    case catalogLinks(names: [String], selected: Binding<Int>)
    
    var rawValue: RawValue {
        switch self {
        case .product(let product):
            return "product" + product.id.uuidString
        case .catalogLinks:
            return "catalogLinks"
        }
    }
    
    var id: String {
        self.rawValue
    }
}

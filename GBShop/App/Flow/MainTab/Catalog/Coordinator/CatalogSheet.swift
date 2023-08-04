//
//  CatalogSheet.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation
import SwiftUI

enum CatalogSheet: Identifiable, Hashable {
    typealias RawValue = String
    
    case product(product: Product)
    case catalogLinks(names: [String], selected: Binding<Int>)
    case reviewCreator(product: Product)
    
    var rawValue: RawValue {
        switch self {
        case .product(let product):
            return "product" + product.id.uuidString
        case .catalogLinks:
            return "catalogLinks"
        case .reviewCreator(let product):
            return "reviewCreator" + product.id.uuidString
        }
    }
    
    var id: String {
        self.rawValue
    }
    
    init?(rawValue: String) {
        return nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CatalogSheet, rhs: CatalogSheet) -> Bool {
        lhs.id == rhs.id
    }
}

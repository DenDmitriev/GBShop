//
//  Product.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct Product: Codable {
    var id: UUID?
    var name: String
    var price: Float
    var description: String
    var category: ProductCategory?
    
    init(id: UUID? = nil,
         name: String,
         price: Float,
         description: String,
         category: ProductCategory? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.category = category
    }
}

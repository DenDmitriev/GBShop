//
//  Product.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: UUID?
    var name: String
    var price: Float
    var description: String
    var categoryID: UUID?

    init(id: UUID? = nil,
         name: String,
         price: Float,
         description: String,
         categoryID: UUID? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.categoryID = categoryID
    }
}

//
//  Product.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct Product: Codable, Identifiable, Hashable, Comparable {
    var id: UUID
    var name: String
    var price: Price
    var description: String
    var image: String
    var categoryID: UUID?

    init(id: UUID? = nil,
         name: String,
         price: Price,
         description: String,
         image: String,
         categoryID: UUID? = nil) {
        self.id = id ?? UUID()
        self.name = name
        self.price = price
        self.image = image
        self.description = description
        self.categoryID = categoryID
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Product, rhs: Product) -> Bool {
        lhs.name > rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

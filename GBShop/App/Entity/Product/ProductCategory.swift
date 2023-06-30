//
//  ProductCategory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct ProductCategory: Codable {
    let id: UUID
    let name: String?
    let description: String?
    
    init(id: UUID? = nil, name: String, description: String) {
        self.id = id ?? UUID()
        self.name = name
        self.description = description
    }
}

//
//  ProductsByCategoryResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct ProductsByCategoryResult: Codable {
    let result: Int
    let page: Int?
    let products: [Product]?
    let errorMessage: String?
}

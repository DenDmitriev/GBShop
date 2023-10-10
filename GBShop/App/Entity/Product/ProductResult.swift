//
//  ProductResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation

struct ProductResult: Codable {
    let result: Int
    let errorMessage: String?
    let product: Product?
}

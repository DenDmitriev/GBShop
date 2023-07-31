//
//  Basket.swift
//  GBShop
//
//  Created by Denis Dmitriev on 08.07.2023.
//

import Foundation

struct Basket: Codable {
    let userID: UUID
    var products: [Product]
    let total: Price
}

extension Basket {
    struct Result: Codable {
        let result: Int
        let basket: Basket?
        let errorMessage: String?
    }
}

extension Basket {
    struct Update: Codable {
        let result: Int
        let userMessage: String?
        let errorMessage: String?
    }
}

extension Basket {
    struct PaymentResult: Codable {
        let result: Int
        let receipt: [ReceiptItem]?
        let total: Double?
        let errorMessage: String?
    }
}

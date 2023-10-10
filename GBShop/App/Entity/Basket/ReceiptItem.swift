//
//  ReceiptItem.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

struct ReceiptItem: Codable {
    let name: String
    let count: Int
    let price: Double
}

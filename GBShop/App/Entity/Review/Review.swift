//
//  Review.swift
//  GBShop
//
//  Created by Denis Dmitriev on 06.07.2023.
//

import Foundation

struct Review: Codable {
    let id: UUID
    let reviewer: String
    let review: String
    let rating: Int
    let productID: UUID
    let createdAt: Date
}

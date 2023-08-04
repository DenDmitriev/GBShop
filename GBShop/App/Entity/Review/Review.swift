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
    
    init(id: UUID, reviewer: String, review: String, rating: Int, productID: UUID, createdAt: Date) {
        self.id = id
        self.reviewer = reviewer
        self.review = review
        self.rating = rating
        self.productID = productID
        self.createdAt = createdAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.reviewer = try container.decode(String.self, forKey: .reviewer)
        self.review = try container.decode(String.self, forKey: .review)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.productID = try container.decode(UUID.self, forKey: .productID)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.createdAt = dateFormatter.date(from: createdAtString) ?? Date.now
    }
}

//
//  GetReviewsResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 06.07.2023.
//

import Foundation

struct GetReviewsResult: Codable {
    let result: Int
    let page: Int
    let reviews: [Review]
    let errorMessage: String?
    let metadata: Metadata
}

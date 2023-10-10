//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.07.2023.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {

    func reviews(for productID: UUID,
                 page: Int,
                 per: Int,
                 completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void)

    func addReview(userID: UUID,
                   productID: UUID,
                   review: String,
                   rating: Int,
                   completionHandler: @escaping (AFDataResponse<ReviewResult>) -> Void)

    func deleteReviews(by reviewID: UUID,
                       completionHandler: @escaping (AFDataResponse<ReviewResult>) -> Void)
}

//
//  ReviewRequest.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.07.2023.
//

import Foundation
import Alamofire

class ReviewRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
//    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    let baseUrl = URL(string: "https://gbshopbe-denisdmitriev.amvera.io")!

    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ReviewRequest: ReviewRequestFactory {

    func reviews(for productID: UUID,
                 page: Int,
                 per: Int,
                 completionHandler: @escaping (AFDataResponse<GetReviewsResult>) -> Void) {
        let requestModel = Reviews(baseUrl: baseUrl,
                                   productID: productID,
                                   page: page,
                                   per: per)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func addReview(userID: UUID,
                   productID: UUID,
                   review: String,
                   rating: Int,
                   completionHandler: @escaping (AFDataResponse<ReviewResult>) -> Void) {
        let requestModel = AddReview(baseUrl: baseUrl,
                                     userID: userID,
                                     productID: productID,
                                     review: review,
                                     rating: rating)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func deleteReviews(by reviewID: UUID,
                       completionHandler: @escaping (AFDataResponse<ReviewResult>) -> Void) {
        let requestModel = DeleteReview(baseUrl: baseUrl,
                                        reviewID: reviewID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ReviewRequest {
    struct Reviews: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .get
        var path: String = "/reviews/get"
        let productID: UUID
        let page: Int
        let per: Int
        var parameters: Parameters? {
            [
                "productID": productID,
                "page": page,
                "per": per
            ]
        }
    }

    struct AddReview: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .post
        var path: String = "/reviews/add"
        let userID: UUID
        let productID: UUID
        let review: String
        let rating: Int
        var parameters: Parameters? {
            [
                "userID": userID,
                "productID": productID,
                "review": review,
                "rating": rating
            ]
        }
    }

    struct DeleteReview: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .delete
        var path: String
        let reviewID: UUID
        var parameters: Parameters?

        init(baseUrl: URL, reviewID: UUID) {
            self.baseUrl = baseUrl
            self.reviewID = reviewID
            self.path = "/reviews/\(reviewID.uuidString)"
        }
    }
}

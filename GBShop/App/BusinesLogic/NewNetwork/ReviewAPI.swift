//
//  ReviewAPI.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation

class ReviewAPI: NetworkAPI {
    
    static func reviews(router: ReviewRequest.Reviews) async -> Result<GetReviewsResult, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: GetReviewsResult = try self.parseData(data: data)
            
            if result.result != .zero {
                return .success(result)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func addReview(router: ReviewRequest.AddReview) async -> Result<ReviewResult, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: ReviewResult = try self.parseData(data: data)
            
            if result.result == 1 {
                return .success(result)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func deleteReviews(router: ReviewRequest.DeleteReview) async -> Result<ReviewResult, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: ReviewResult = try self.parseData(data: data)
            
            if result.result == 1  {
                return .success(result)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
}

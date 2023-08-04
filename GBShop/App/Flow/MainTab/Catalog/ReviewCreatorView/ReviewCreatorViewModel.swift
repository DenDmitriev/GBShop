//
//  ReviewCreatorViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.08.2023.
//

import Foundation

class ReviewCreatorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let product: Product
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    init(product: Product) {
        self.product = product
    }
    
    // MARK: - Functions
    
    func addReview(text: String, rating: Int?, completion: @escaping ((Bool) -> Void)) {
        guard
            let userID = UserSession.shared.user?.id,
            let rating = rating,
            !text.isEmpty
        else { return }
        
        let reviewRequest = requestFactory.makeReviewRequestFactory()
        reviewRequest.addReview(userID: userID, productID: product.id, review: text, rating: rating) { response in
            switch response.result {
            case .success(let reviewResult):
                print(reviewResult)
                completion(reviewResult.result == 1)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    // MARK: - Private functions
}

//
//  ReviewCreatorViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.08.2023.
//

import Foundation
import Firebase

class ReviewCreatorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var hasError = false
    @Published var error: APIError?
    @Published var isPublished = true
    let product: Product
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    init(product: Product) {
        self.product = product
    }
    
    // MARK: - Functions
    
    func addReview(text: String, rating: Int?) async {
        Analytics.logEvent("Add review", parameters: [
            AnalyticsParameterItemID: product.id.uuidString
        ])
        
        guard
            let userID = UserSession.shared.user?.id,
            let rating = rating,
            !text.isEmpty
        else { return }
        let token = UserSession.shared.token
        
        let requestModel = ReviewRequest.AddReview(
            baseUrl: URL(string: "baseURL")!,
            headers: [.authorization(bearerToken: token)],
            userID: userID,
            productID: product.id,
            review: text,
            rating: rating
        )
        Crashlytics.crashlytics().log("Adding new review")
        let response = await ReviewAPI.addReview(router: requestModel)
        
        switch response {
        case .success:
            await MainActor.run {
                isPublished = false
            }
            Crashlytics.crashlytics().log("Added new review")
        case .failure(let failure):
            await MainActor.run {
                error = .error(message: failure.localizedDescription)
                hasError = true
            }
            Crashlytics.crashlytics().record(error: failure)
        }
    }
    
    // MARK: - Private functions
}

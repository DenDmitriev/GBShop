//
//  ProductViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var reviews: [Review] = []
    @Published var product: Product
    
    private let requestFactory = RequestFactory()

    // MARK: - Initialization
    
    init(product: Product, reviews: [Review]? = nil) {
        self.reviews = reviews ?? []
        self.product = product
        getReviews()
    }

    // MARK: - Functions
    
    func getReviews() {
        let reviewRequest = requestFactory.makeReviewRequestFactory()
        reviewRequest.reviews(for: product.id, page: 1, per: 5) { response in
            switch response.result {
            case .success(let getReviewResult):
                DispatchQueue.main.async {
                    if let reviews = getReviewResult.reviews {
                        self.reviews = reviews.sorted(by: { $0.createdAt > $1.createdAt })
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private functions

}

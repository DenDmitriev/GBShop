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
    
    private var product: Product
    private let requestFactory = RequestFactory()

    // MARK: - Initialization
    
    init(product: Product, reviews: [Review]? = nil) {
        self.reviews = reviews ?? []
        self.product = product
    }

    // MARK: - Functions
    
    func getReviews() {
        let reviewRequest = requestFactory.makeReviewRequestFactory()
        reviewRequest.reviews(for: product.id, page: .zero, per: 5) { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.reviews = data.reviews.sorted(by: { $0.createdAt > $1.createdAt })
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private functions

}

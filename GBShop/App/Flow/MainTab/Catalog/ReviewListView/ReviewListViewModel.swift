//
//  ReviewListViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.08.2023.
//

import Foundation
import Firebase

class ReviewListViewModel: ObservableObject, Pageable {
    
    // MARK: - Properties
    
    @Published var reviews = [Review]()
    @Published var product: Product
    
    var metadata: Metadata = .default
    var canLoadMorePages: Bool { metadata.hasNextPage }
    private let requestFactory = RequestFactory()
    var state: PagingState = .loaded
    var threshold: Int { metadata.per }
    
    // MARK: - Initialization
    
    init(product: Product) {
        self.product = product
    }
    
    // MARK: - Functions
    
    func getReviews(page: Int = 1, per: Int? = nil) async {
        let token = UserSession.shared.token
        let requestModel = ReviewRequest.Reviews(
            baseUrl: URL(string: "baseURL")!,
            headers: [.authorization(bearerToken: token)],
            productID: product.id,
            page: page,
            per: per ?? metadata.per
        )
        state = page <= 1 ? .loadingFirstPage : .loadingNextPage
        let response = await ReviewAPI.reviews(router: requestModel)
        switch response {
        case .success(let success):
            if var reviews = success.reviews,
               let metadata = success.metadata {
                reviews.sort(by: { $0.createdAt > $1.createdAt })
                let allReviews = self.state == .loadingFirstPage ? reviews : self.reviews + reviews
                await MainActor.run {
                    self.reviews = allReviews
                    self.metadata = metadata
                    self.reviews.forEach({ review in
                        print("👾", review.id.uuidString)
                    })
                    self.state = .loaded
                }
            }
            Crashlytics.crashlytics().log("Reviews fetch")
        case .failure(let failure):
            await MainActor.run {
                self.state = .error(error: failure)
            }
            Crashlytics.crashlytics().record(error: failure)
        }
    }
    
    func onItemAppear(_ item: Review) async {
        if !canLoadMorePages {
            print("⤵️ can't Load More Pages")
            return
        }
        
        if state == .loadingNextPage || state == .loadingFirstPage {
            print("⤵️ already load")
            return
        }
        
        guard let index = reviews.firstIndex(where: { $0.id == item.id }) else {
            print("⤵️ can't get first index")
            return
        }
        
        let thresholdIndex = reviews.index(reviews.endIndex, offsetBy: -threshold)
        if index != thresholdIndex {
            print("⤵️ get threshold")
            return
        }
        
        print("⤵️ load next page")
        
        guard let nextPage = metadata.nextPage else {
            return
        }
        
        await getReviews(page: nextPage, per: metadata.per)
    }
}

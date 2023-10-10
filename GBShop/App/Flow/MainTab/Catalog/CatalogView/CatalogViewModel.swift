//
//  CatalogViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation
import Firebase

class CatalogViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var category: [ProductCategory] = []
    @Published var scrollingCategory: Int = .zero
    @Published var categoryViewModels = [CategoryViewModel]()
    @Published var error: APIError?
    @Published var hasError: Bool = false
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    // MARK: - Functions
    
    func getCatalog() async {
        Analytics.logEvent("Get catalog", parameters: nil)
        
        let token = UserSession.shared.token
        let requestModel = ProductRequest.All(
            baseUrl: URL(string: "baseUrl")!,
            headers: [.authorization(bearerToken: token)]
        )
        let response = await ProductAPI.categories(router: requestModel)
        switch response {
        case .success(let success):
            await MainActor.run {
                self.category = success
                self.categoryViewModels = success.map({ CategoryViewModel(category: $0) })
            }
            Crashlytics.crashlytics().log("Catalog fetch")
        case .failure(let failure):
            await MainActor.run {
                self.error = APIError.error(message: failure.localizedDescription)
                self.hasError = true
            }
            Crashlytics.crashlytics().record(error: failure)
        }
        
    }
    
    // MARK: - Private functions
}

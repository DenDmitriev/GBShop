//
//  ProductsViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class CategoryViewModel: ObservableObject {

    // MARK: - Properties

    @Published var products: [Product] = []
    @Published var hasError: Bool = false
    @Published var error: APIError?
    let userSession = UserSession.shared
    let category: ProductCategory

    // MARK: - Initialization

    init(category: ProductCategory) {
        self.category = category
    }

    // MARK: - Functions

    func getProducts() async {
        let token = userSession.token
        let requestModel = ProductRequest.ProductsByCategory(
            baseUrl: URL(string: "baseURL")!,
            headers: [.authorization(bearerToken: token)], page: .zero,
            per: 10,
            categoryID: category.id
        )
        let response = await ProductAPI.products(router: requestModel)
        
        switch response {
        case .success(let success):
            await MainActor.run {
                self.products = success
            }
        case .failure(let failure):
            await MainActor.run {
                self.error = APIError.error(message: failure.localizedDescription)
                self.hasError = true
            }
        }
    }
}

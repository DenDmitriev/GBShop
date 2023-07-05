//
//  ProductsViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class ProductsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var products: [Product] = []

    private let category: ProductCategory
    private let requestFactory = RequestFactory()

    // MARK: - Initialization

    init(category: ProductCategory) {
        self.category = category
        getProducts()
    }

    // MARK: - Functions

    func getProducts() {
        let productRequest = requestFactory.makeProductRequestFactory()
        productRequest.products(by: category.id, page: .zero) { response in
            switch response.result {
            case .success(let productsResult):
                if let products = productsResult.products {
                    DispatchQueue.main.async {
                        self.products = products
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private functions

}

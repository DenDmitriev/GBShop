//
//  ProductsViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    let category: ProductCategory
    let requestFactory = RequestFactory()
    
    init(category: ProductCategory) {
        self.category = category
        fetchProducts()
    }
    
    func fetchProducts() {
        let productRequest = requestFactory.makeProductRequestFatory()
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
}

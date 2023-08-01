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
    let userSession = UserSession.shared
    let category: ProductCategory
    private let requestFactory = RequestFactory()

    // MARK: - Initialization

    init(category: ProductCategory) {
        self.category = category
        getProducts()
//        mockProducts()
    }

    // MARK: - Functions

    func getProducts() {
        let productRequest = requestFactory.makeProductRequestFactory()
        productRequest.products(by: category.id, page: .zero, per: 10) { response in
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
    
    private func mockProducts() {
        let mockeProducts = [
            Product(name: "Чипсы картофельные Lay's Maxx",
                    price: Price(price: 129, discount: .zero),
                    description: "Куриные крылышки барбекю рифлёные",
                    image: "https://cm.samokat.ru/processed/l/original/158334_425819778.jpg")
        ]
        self.products = mockeProducts
    }

}

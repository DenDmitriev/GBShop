//
//  CatalogViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {

    // MARK: - Properties

    @Published var category: [ProductCategory] = []

    private let requestFactory = RequestFactory()

    // MARK: - Initialization

    init() {
        getCatalog()
    }

    // MARK: - Functions

    func getCatalog() {
        let productRequest = requestFactory.makeProductRequestFactory()
        productRequest.categories { response in
            switch response.result {
            case .success(let catalog):
                DispatchQueue.main.async {
                    self.category = catalog
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private functions
}

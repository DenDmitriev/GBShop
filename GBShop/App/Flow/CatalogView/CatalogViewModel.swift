//
//  CatalogViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    @Published var category: [ProductCategory] = []
    
    let requestFactory = RequestFactory()
    
    init() {
        fetchCatalog()
    }
    
    func fetchCatalog() {
        let productRequest = requestFactory.makeProductRequestFatory()
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
}

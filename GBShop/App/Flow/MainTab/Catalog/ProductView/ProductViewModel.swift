//
//  ProductViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var product: Product

    // MARK: - Initialization
    
    init(product: Product) {
        self.product = product
    }

    // MARK: - Functions

    // MARK: - Private functions

}

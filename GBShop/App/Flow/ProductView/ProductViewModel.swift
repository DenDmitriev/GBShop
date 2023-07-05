//
//  ProductViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    // MARK: - Functions
    
    func order(id: UUID?, count: Int? = 1) {
        guard let id = id else { return }
        print(id, count)
    }
    
    // MARK: - Private functions
    
}

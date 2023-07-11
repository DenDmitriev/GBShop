//
//  OrderService.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import Foundation

final class OrderService: ObservableObject {
    
    @Published var order: [Product: Int] = [:]
    
    var total: Double {
        return order.reduce(0.0) { partialResult, item in
            partialResult + item.key.price.discountPrice * Double(item.value)
        }
    }
    
    func update(product: Product, count: Int) {
        if count <= .zero {
            order.removeValue(forKey: product)
        } else {
            order[product] = count
        }
    }
    
    func syncRequest() {
        
    }
}

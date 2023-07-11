//
//  ProductViewItemModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 08.07.2023.
//

import Foundation
import SwiftUI
import UIKit.UIImage

class ProductViewItemModel: ObservableObject {
    
    let orderService: OrderService
    
    init() {
        self.orderService = UserSession.shared.orderService
    }
    
    func updateBasket(with product: Product, count: Int) {
        orderService.update(product: product, count: count)
    }
}

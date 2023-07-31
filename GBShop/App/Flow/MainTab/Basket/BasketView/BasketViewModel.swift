//
//  BasketViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import Foundation
import SwiftUI

class BasketViewModel: ObservableObject {
    
    @Published var lookReceipt: Bool = false
    var coordinator: BasketCoordinator
    
    init(coordinator: BasketCoordinator) {
        self.coordinator = coordinator
    }
    
    func secureCard() -> String? {
        guard let cardNumber = UserSession.shared.user?.creditCard else { return nil }
        let publicOffset = -4
        let startIndex = cardNumber.index(cardNumber.endIndex, offsetBy: publicOffset)
        let range: Range<String.Index> = startIndex..<cardNumber.endIndex
        let secureRange = cardNumber.count + publicOffset
        var secureNumber = String(repeating: "•", count: secureRange)
        return secureNumber + cardNumber[range].lowercased()
    }
    
    func basketIsEmpty(orderService: OrderService) -> Bool {
        let orderCount = orderService.order.filter { element in
            return element.value > 0
        }.count
        return orderCount > .zero ? false : true
    }
    
    func payment(orderService: OrderService) {
        orderService.payment { [weak self] receipt in
            guard let receipt = receipt else { return }
            self?.coordinator.present(sheet: .receipt(receipt: receipt))
        }
    }
    
}

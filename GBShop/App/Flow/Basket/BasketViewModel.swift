//
//  BasketViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import Foundation
import SwiftUI

class BasketViewModel: ObservableObject {
    
    func secureCard() -> String? {
        guard let cardNumber = UserSession.shared.user?.creditCard else { return nil }
        let publicOffset = -4
        let startIndex = cardNumber.index(cardNumber.endIndex, offsetBy: publicOffset)
        let range: Range<String.Index> = startIndex..<cardNumber.endIndex
        let secureRange = cardNumber.count + publicOffset
        var secureNumber = String(repeating: "•", count: secureRange)
        return secureNumber + cardNumber[range].lowercased()
    }

}

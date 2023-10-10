//
//  BasketSheet.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import Foundation

enum BasketSheet: Identifiable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        return nil
    }
    
    var rawValue: String {
        switch self {
        case .receipt:
            return "receipt"
        }
    }
    
    var id: String {
        self.rawValue
    }
    
    case receipt(receipt: Receipt)
}

//
//  Sheet.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

enum Sheet: String, Identifiable {
    case receipt
    
    var id: String {
        self.rawValue
    }
}

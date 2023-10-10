//
//  MainTab.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

enum MainTab: String, Identifiable {
    case catalog
    case basket
    case user
    
    var id: String {
        self.rawValue
    }
}

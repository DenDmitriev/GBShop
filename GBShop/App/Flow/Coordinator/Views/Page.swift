//
//  Page.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation

enum Page: String, Identifiable {
    case someRootPage
    
    var id: String {
        self.rawValue
    }
}

//
//  UserPage.swift
//  GBShop
//
//  Created by Denis Dmitriev on 27.07.2023.
//

import Foundation

enum UserPage: String, Identifiable {
    case user, secure
    
    var id: String {
        self.rawValue
    }
}

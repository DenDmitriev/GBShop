//
//  User.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

struct User: Codable {
    let id: UUID
    var name: String
    var password: String?
    var email: String
    var creditCard: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case password = "password"
        case email = "email"
        case creditCard = "creditCard"
    }
}

extension User {
    struct Create: Codable {
        let name: String
        let email: String
        let password: String
        let confirmPassword: String
        let creditCard: String
    }
}

extension User {
    struct Update: Codable {
        let id: UUID
        let name: String
        let email: String
        let creditCard: String
    }
}

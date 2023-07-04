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
    var email: String
    var creditCard: String
    
    init(from login: User.Login) {
        self.id = login.id
        self.name = login.name
        self.email = login.email
        self.creditCard = login.creditCard
    }
    
    init(from me: User.Public) {
        self.id = me.id
        self.name = me.name
        self.email = me.email
        self.creditCard = me.creditCard
    }
}

extension User {
    struct Public: Codable {
        let id: UUID
        var name: String
        var email: String
        var creditCard: String
    }
    
    struct Login: Codable {
        let id: UUID
        var name: String
        var email: String
        var creditCard: String
        let token: String
    }
    
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

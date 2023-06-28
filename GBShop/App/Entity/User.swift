//
//  User.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

struct User: Codable {
    let id: UUID
    var login: String
    var name: String
    var lastname: String
    var password: String
    var email: String
    var gender: String
    var creditCard: String
    var bio: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case name = "name"
        case lastname = "lastname"
        case password = "password"
        case email = "email"
        case gender = "gender"
        case creditCard = "creditCard"
        case bio = "bio"
    }
    
    init(id: UUID? = nil,
         login: String,
         name: String,
         lastname: String,
         password: String,
         email: String,
         gender: String,
         creditCard: String,
         bio: String) {
        self.id = id ?? UUID()
        self.login = login
        self.name = name
        self.lastname = lastname
        self.password = password
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
    }
}

//
//  LoginResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User.Login?
    let errorMessage: String?
}


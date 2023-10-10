//
//  ChangeUserDataResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

struct ChangeUserDataResult: Codable {
    let result: Int
    let user: User?
    let userMessage: String?
    let errorMessage: String?
}

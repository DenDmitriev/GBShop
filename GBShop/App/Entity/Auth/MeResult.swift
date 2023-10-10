//
//  MeResult.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.07.2023.
//

import Foundation

struct MeResult: Codable {
    let result: Int
    let user: User.Public?
    let errorMessage: String?
}

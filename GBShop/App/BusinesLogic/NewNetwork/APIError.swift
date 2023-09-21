//
//  APIError.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation

enum APIError: Error {
    case empty
    case error(message: String?)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        let comment = "Vegetable error description"
        switch self {
        case .empty:
            return NSLocalizedString("Result is empty", comment: comment)
        case .error(let message):
            return NSLocalizedString("\(message ?? "Unknown error")", comment: comment)
        }
    }
}

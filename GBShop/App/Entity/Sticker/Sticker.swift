//
//  Sticker.swift
//  GBShop
//
//  Created by Denis Dmitriev on 09.07.2023.
//

import Foundation
import UIKit.UIColor

enum Sticker: Hashable {
    case discount(percent: Int)
    case new
    case custom(text: String, color: UIColor)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .discount(let value):
            hasher.combine(value)
        case .new:
            break
        case .custom(let text, let color):
            hasher.combine(text)
            hasher.combine(color)
        }
    }
}

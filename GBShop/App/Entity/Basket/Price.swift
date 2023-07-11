//
//  Price.swift
//  GBShop
//
//  Created by Denis Dmitriev on 08.07.2023.
//

import Foundation

struct Price: Codable {
    let price: Double
    let discount: Int
    
    var discountPrice: Double {
        let part = Decimal(discount) / 100
        let discountPrice = (1 - part) * Decimal(price)
        return NSDecimalNumber(decimal: discountPrice)
            .doubleValue
    }
    
    enum CodingKeys: String, CodingKey {
        case price
        case discount
    }
    
    init(price: Double, discount: Int) {
        self.price = price
        self.discount = discount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try values.decode(Double.self, forKey: .price)
        discount = try values.decode(Int.self, forKey: .discount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(price, forKey: .price)
        try container.encode(discount, forKey: .discount)
    }
}

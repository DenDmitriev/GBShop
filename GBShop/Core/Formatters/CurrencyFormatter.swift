//
//  CurrencyFormatter.swift
//  GBShop
//
//  Created by Denis Dmitriev on 11.07.2023.
//

import Foundation

class CurrencyFormatter {
    
    static let shared = CurrencyFormatter()
    
    private init() {}
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(components: .init(identifier: "ru_RU"))
        formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = " "
        formatter.minimumFractionDigits = .zero
        return formatter
    }()
    
    func formatter(by price: Double) -> String {
        let string: String?
        if price >= .zero {
            string = CurrencyFormatter.formatter.string(for: price)
        } else {
            string = CurrencyFormatter.formatter.string(for: 0.0)
        }
        return string ?? ""
    }
}

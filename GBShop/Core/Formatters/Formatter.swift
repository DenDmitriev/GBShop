//
//  CurrencyFormatter.swift
//  GBShop
//
//  Created by Denis Dmitriev on 11.07.2023.
//

import Foundation

class Formatter {
    
    static let shared = Formatter()
    
    static let locale: Locale = Locale.init(components: .init(identifier: "ru_RU"))
    
    private init() {}
    
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = " "
        formatter.minimumFractionDigits = .zero
        return formatter
    }()
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .medium
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    
    func currency(by price: Double) -> String {
        let string: String?
        if price >= .zero {
            string = Formatter.currencyFormatter.string(for: price)
        } else {
            string = Formatter.currencyFormatter.string(for: 0.0)
        }
        
        return string ?? ""
    }
    
    func date(by date: Date, style: DateFormatter.Style? = nil) -> String {
        let formatter = Formatter.dateFormatter
        if let style = style {
            formatter.dateStyle = style
        }
        let string = Formatter.dateFormatter.string(from: date)
        
        return string
    }
}

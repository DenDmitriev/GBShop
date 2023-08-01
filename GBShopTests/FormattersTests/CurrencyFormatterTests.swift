//
//  CurrencyFormatterTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import XCTest
@testable import GBShop

final class CurrencyFormatterTests: XCTestCase {

    func testPriceWithDecimalValueZero() {
        let price: Double = 99.0
        let formatter = CurrencyFormatter.shared
        let formattedPrice = formatter.formatter(by: price)
        XCTAssertEqual(formattedPrice, "99 ₽")
    }
    
    func testPriceWithDecimalValueNotZero() {
        let price: Double = 99.9
        let formatter = CurrencyFormatter.shared
        let formattedPrice = formatter.formatter(by: price)
        XCTAssertEqual(formattedPrice, "99,9 ₽")
    }
    
    func testPriceWithDecimalValue() {
        let price: Double = 99.99
        let formatter = CurrencyFormatter.shared
        let formattedPrice = formatter.formatter(by: price)
        XCTAssertEqual(formattedPrice, "99,99 ₽")
    }
    
    func testPriceWithZero() {
        let price: Double = .zero
        let formatter = CurrencyFormatter.shared
        let formattedPrice = formatter.formatter(by: price)
        XCTAssertEqual(formattedPrice, "0 ₽")
    }
}

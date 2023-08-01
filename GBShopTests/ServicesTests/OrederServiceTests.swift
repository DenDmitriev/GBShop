//
//  OrderServiceTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import XCTest
@testable import GBShop

final class OrderServiceTests: XCTestCase {
    
    var service: OrderService!
    
    override func setUp() {
        super.setUp()
        service = OrderService()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTotal() {
        var mockOrder = [Product: Int]()
        let mockProductA = Product(name: "", price: Price(price: 10, discount: 10), description: "", image: "")
        let countA = 1
        let mockProductB = Product(name: "", price: Price(price: 5, discount: 20), description: "", image: "")
        let countB = 2
        mockOrder[mockProductA] = countA
        mockOrder[mockProductB] = countB
        service.order = mockOrder
        
        let serviceTotal = service.total
        // A: (10 - 10%) * 1 = 9.0
        // B: (5 - 10%) * 2 = 8.0
        let testTotal = 17.0 // 9.0 + 8.0
        
        XCTAssertEqual(serviceTotal, testTotal)
    }

    func testCount() {
        var mockOrder = [Product: Int]()
        let mockProductA = Product(name: "", price: Price(price: 10, discount: 10), description: "", image: "")
        let countA = 1
        mockOrder[mockProductA] = countA
        service.order = mockOrder
        
        let bindCount = service.count(for: mockProductA)
        bindCount.wrappedValue = 2
        
        XCTAssertEqual(service.order[mockProductA], bindCount.wrappedValue)
    }

}

//
//  UserDefaultsStoreTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import XCTest
@testable import GBShop

final class UserDefaultsStoreTests: XCTestCase {
    
    var service: OrderService!
    var userName: String?
    
    override func setUp() {
        super.setUp()
        userName = UserDefaultsStore.userName
    }
    
    override func tearDown() {
        super.tearDown()
        if let userName = userName {
            UserDefaultsStore.userName = userName
        }
    }
    
    func testUserName() {
        let mockName = "mockName"
        UserDefaultsStore.userName = mockName
        XCTAssertEqual(UserDefaultsStore.userName, mockName)
    }

}

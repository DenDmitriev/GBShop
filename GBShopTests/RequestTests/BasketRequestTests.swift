//
//  BasketRequestTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import Foundation
import XCTest
@testable import GBShop

final class BasketRequestTests: XCTestCase {
    var requestFactory: RequestFactory!
    var request: BasketRequestFactory!
    let expectation = XCTestExpectation(description: "basketRequests")
    
    override func setUpWithError() throws {
        super.setUp()
        requestFactory = RequestFactory()
        request = requestFactory.makeBasketRequestFactory()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        request = nil
        requestFactory = nil
    }
    
    func testGetBasket() {
        let mockUserID = UUID()
        request.getBasket(of: mockUserID) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, .zero)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAddToBasket() {
        let mockUserID = UUID()
        let mockProductID = UUID()
        request.addToBasket(of: mockUserID, for: mockProductID, on: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, .zero)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDeleteFromBasket() {
        let mockUserID = UUID()
        let mockProductID = UUID()
        request.deleteFromBasket(of: mockUserID, for: mockProductID, on: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, .zero)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPayment() {
        let mockUserID = UUID()
        request.payment(of: mockUserID) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, .zero)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

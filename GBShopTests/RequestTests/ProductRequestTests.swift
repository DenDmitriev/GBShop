//
//  ProductRequestTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 01.07.2023.
//

import Foundation
import XCTest
@testable import GBShop

final class ProductRequestTests: XCTestCase {

    var requestFactory: RequestFactory!
    var request: ProductRequestFactory!
    let expectation = XCTestExpectation(description: "userRequests")

    override func setUpWithError() throws {
        super.setUp()
        requestFactory = RequestFactory()
        request = requestFactory.makeProductRequestFactory()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        request = nil
        requestFactory = nil
    }

    func testProduct() {
        request.product(id: UUID(uuidString: "2DE48542-FBD2-44D4-9A16-1A10D99887C4")!) { response in
            switch response.result {
            case .success(let productResult):
                print(productResult)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testCatalog() {
        request.categories { response in
            switch response.result {
            case .success(let categories):
                print(categories)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testProducts() {
        let categoryID = UUID(uuidString: "FADBC09E-83FB-4FF4-B3B6-C412B6CBF4CB")!
        request.products(by: categoryID, page: .zero, per: .zero) { response in
            switch response.result {
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

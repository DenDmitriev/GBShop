//
//  ReviewRequestTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import Foundation
import XCTest
@testable import GBShop

final class ReviewRequestTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    var request: ReviewRequestFactory!
    let expectation = XCTestExpectation(description: "reviewRequests")
    
    override func setUpWithError() throws {
        super.setUp()
        requestFactory = RequestFactory()
        request = requestFactory.makeReviewRequestFactory()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        request = nil
        requestFactory = nil
    }
    
    func testReviews() {
        let mockProductID = UUID()
        request.reviews(for: mockProductID, page: 1, per: 1) { response in
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
    
    func testAddReview() {
        let mockProductID = UUID()
        request.addReview(userID: UUID(), productID: mockProductID, review: "My review", rating: 5) { response in
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
    
    func testDeleteReview() {
        let mockProductID = UUID()
        request.deleteReviews(by: mockProductID) { response in
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

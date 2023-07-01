//
//  AuthTest.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 26.06.2023.
//

import XCTest
import Alamofire
@testable import GBShop

final class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
        
        AF.request(urlRequest)
            .responseCodable(errorParser: errorParser) { [weak self] (response: AFDataResponse<PostStub>) in
                switch response.result {
                case .success(_):
                    break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 5)
    }
}

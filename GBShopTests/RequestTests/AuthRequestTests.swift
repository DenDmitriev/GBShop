//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 29.06.2023.
//

import Foundation
import XCTest
import Combine
@testable import GBShop

final class AuthRequestTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    var request: AuthRequestFactory!
    let expectation = XCTestExpectation(description: "authRequests")
    
    var userCreate = User.Create(
        name: "Name",
        email: "some@some.ru",
        password: "secret42",
        confirmPassword: "secret42",
        creditCard: "1234123412341234")
    
    override func setUpWithError() throws {
        super.setUp()
        print(#function)
        requestFactory = RequestFactory()
        request = requestFactory.makeAuthRequestFactory()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        request = nil
        requestFactory = nil
    }
    
    func testRegister() {
        request.registerUser(create: self.userCreate) { response in
            switch response.result {
            case .success(let register):
                print(#function, register)
                XCTAssert(register.result == 0 || register.result == 1)
            case .failure(let error):
                print(#function, error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testLogin() {
        request.registerUser(create: self.userCreate) { response in
            switch response.result {
            case .success(let register):
                print(#function, register)
                
                self.request.login(email: self.userCreate.email, password: self.userCreate.password) { response in
                    switch response.result {
                    case .success(let result):
                        print(#function, result)
                        XCTAssertTrue(result.result == 1 || result.result == 0)
                    case .failure(let error):
                        print(#function, error.localizedDescription)
                        XCTFail("failure response")
                    }
                    self.expectation.fulfill()
                }
                
            case .failure(let error):
                print(#function, error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testMeWithToken() {
        let token = "mockToken"
        request.me(token: token) { response in
            switch response.result {
            case .success(let result):
                print(#function, result)
                XCTAssertEqual(result.result, .zero)
            case .failure(let error):
                print(#function, error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testChangeUserData() {
        request.registerUser(create: self.userCreate) { response in
            switch response.result {
            case .success(let register):
                print(#function, register)
                
                let userUpdate = User.Update(id: UUID(),
                                             name: "name",
                                             email: "email@email.ru",
                                             creditCard: "1234123412341234")
                self.request.changeUserData(update: userUpdate) { response in
                    switch response.result {
                    case .success(let changeUserData):
                        print(#function, changeUserData)
                        XCTAssertEqual(changeUserData.result, .zero)
                    case .failure(let error):
                        print(#function, error.localizedDescription)
                        XCTFail("failure response")
                    }
                    self.expectation.fulfill()
                }
                
            case .failure(let error):
                print(#function, error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testLogout() {
        let mockID = UUID()
        request.logout(userId: mockID) { response in
            switch response.result {
            case .success(let logout):
                print(#function, logout)
                XCTAssertEqual(logout.result, .zero)
            case .failure(let error):
                print(#function, error.localizedDescription)
                XCTFail("failure response")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
}

//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 29.06.2023.
//

import Foundation
import XCTest
@testable import GBShop

/*
 {
     "id": "89675782-1A65-4002-B6F8-2D3FE6F0B299",
     "email": "mail@mail.ru",
     "login": "login",
     "name": "name",
     "bio": "Awesome bio",
     "gender": "m",
     "lastname": "lastname",
     "creditCard": "2872389-2424-234224-233",
     "password": "password"
 }
 */

final class AuthTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    var request: AuthRequestFactory!
    let expectation = XCTestExpectation(description: "userRequests")
    
    var user = User(
        id: UUID(uuidString: "89675782-1A65-4002-B6F8-2D3FE6F0B299"),
        login: "login",
        name: "name",
        lastname: "lastname",
        password: "password",
        email: "mail@mail.ru",
        gender: "m",
        creditCard: "2872389-2424-234224-233",
        bio: "Awesome bio")

    override func setUpWithError() throws {
        super.setUp()
        requestFactory = RequestFactory()
        request = requestFactory.makeAuthRequestFatory()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        request = nil
        requestFactory = nil
    }
    
    func testRegister() {
        request.registerUser(user: user) { response in
            switch response.result {
            case .success(let register):
                print(register)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testChangeUserData() {
        user.email = "newMail@mail.ru"
        request.changeUserData(user: user) { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLogin() {
        request.login(login: user.login, password: user.password) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLogout() {
        request.logout(userId: user.id) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
}

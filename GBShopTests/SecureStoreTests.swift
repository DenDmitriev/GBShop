//
//  SecureStoreTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 04.07.2023.
//

import XCTest
@testable import GBShop

class SecureStoreTests: XCTestCase {
  var keychainWrapper: KeychainWrapper!
  
  override func setUp() {
    super.setUp()
      keychainWrapper = KeychainWrapper()
  }

  override func tearDown() {
    try? keychainWrapper.removeAllValues()
    super.tearDown()
  }
  
  func testSaveGenericPassword() {
    do {
      try keychainWrapper.setValue("pwd_1234", for: "genericPassword")
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testReadGenericPassword() {
    do {
      try keychainWrapper.setValue("pwd_1234", for: "genericPassword")
      let password = try keychainWrapper.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch (let e) {
      XCTFail("Reading generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testUpdateGenericPassword() {
    do {
      try keychainWrapper.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapper.setValue("pwd_1235", for: "genericPassword")
      let password = try keychainWrapper.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch (let e) {
      XCTFail("Updating generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveGenericPassword() {
    do {
      try keychainWrapper.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapper.removeValue(for: "genericPassword")
      XCTAssertNil(try keychainWrapper.getValue(for: "genericPassword"))
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveAllGenericPasswords() {
    do {
      try keychainWrapper.setValue("pwd_1234", for: "genericPassword")
      try keychainWrapper.setValue("pwd_1235", for: "genericPassword2")
      try keychainWrapper.removeAllValues()
      XCTAssertNil(try keychainWrapper.getValue(for: "genericPassword"))
      XCTAssertNil(try keychainWrapper.getValue(for: "genericPassword2"))
    } catch (let e) {
      XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
    }
  }
}

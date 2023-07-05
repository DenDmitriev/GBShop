//
//  SecureStoreTests.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 04.07.2023.
//

import XCTest
@testable import GBShop

class SecureStoreTests: XCTestCase {
  var secureStore: SecureStore!
  
  override func setUp() {
    super.setUp()
      secureStore = SecureStore()
  }

  override func tearDown() {
    try? secureStore.removeAllValues()
    super.tearDown()
  }
  
  func testSaveGenericPassword() {
    do {
      try secureStore.setValue("pwd_1234", for: "genericPassword")
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testReadGenericPassword() {
    do {
      try secureStore.setValue("pwd_1234", for: "genericPassword")
      let password = try secureStore.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch (let e) {
      XCTFail("Reading generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testUpdateGenericPassword() {
    do {
      try secureStore.setValue("pwd_1234", for: "genericPassword")
      try secureStore.setValue("pwd_1235", for: "genericPassword")
      let password = try secureStore.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch (let e) {
      XCTFail("Updating generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveGenericPassword() {
    do {
      try secureStore.setValue("pwd_1234", for: "genericPassword")
      try secureStore.removeValue(for: "genericPassword")
      XCTAssertNil(try secureStore.getValue(for: "genericPassword"))
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveAllGenericPasswords() {
    do {
      try secureStore.setValue("pwd_1234", for: "genericPassword")
      try secureStore.setValue("pwd_1235", for: "genericPassword2")
      try secureStore.removeAllValues()
      XCTAssertNil(try secureStore.getValue(for: "genericPassword"))
      XCTAssertNil(try secureStore.getValue(for: "genericPassword2"))
    } catch (let e) {
      XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
    }
  }
}

//
//  SnapshotGBShopUITests.swift
//  GBShopUITests
//
//  Created by Denis Dmitriev on 04.10.2023.
//

import XCTest

final class SnapshotGBShopUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation
        // required for your tests before they run.
        // The setUp method is a good place to do this.
        
        setupSnapshot(app)
        
        // UI tests must launch the application that they test.
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateSnapshots() throws {
        
        snapshot("LoginScreen")
        
        app.textFields["email"].tap()
        app.textFields["email"].typeText("test@vapor.codes")
        let passwordSecureTextField = app.secureTextFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("secret42")
        sleep(UInt32(1))
        app.buttons["login"].tap()
        
        sleep(UInt32(1))
        
        snapshot("CatalogScreen1")
        
        app.scrollViews.firstMatch.children(matching: .any).firstMatch.tap()
        
        app.scrollViews.firstMatch.otherElements.children(matching: .button)["order"].tap()
        
        snapshot("ProductScreen")
        
        app.swipeDown(velocity: .fast)
        
        app.scrollViews.firstMatch.children(matching: .any).buttons["catalog"].firstMatch.tap()
        
        app.buttons.allElementsBoundByIndex.filter { $0.label.contains("Мясо и рыба") }.first?.tap()
        
        app
            .scrollViews
            .allElementsBoundByAccessibilityElement.filter { $0.frame.minY > 0 }
            .first?.buttons["order"]
            .firstMatch
            .tap()
        
        snapshot("CatalogScreen2")
        
        app.tabBars.buttons["Basket"].tap()
        
        snapshot("BasketScreen")
        
        app.buttons["pay"].tap()
        
        sleep(UInt32(1))
        
        snapshot("ReceiptScreen")
        
        app.swipeDown(velocity: .fast)
        
        app.tabBars.buttons["User"].tap()
        
        snapshot("UserScreen")
        
        app.buttons["logout"].tap()
    }
}

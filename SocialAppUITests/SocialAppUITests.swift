//
//  SocialAppUITests.swift
//  SocialAppUITests
//
//  Created by Spam C. on 2/3/23.
//

import XCTest

final class SocialAppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test() throws {
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("ejtest1@gmail.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("123456")
        app.buttons["Login"].tap()
        app.buttons["add"].tap()
        
        let whatSNewJuanTextView = app.textViews.containing(.staticText, identifier:"What’s new, Juan?").element
        whatSNewJuanTextView.tap()
        whatSNewJuanTextView.typeText("Good morning!")
        app.navigationBars["Create Post"].buttons["Publish"].tap()
        XCTAssertTrue(app.buttons["add"].exists)
    }
}

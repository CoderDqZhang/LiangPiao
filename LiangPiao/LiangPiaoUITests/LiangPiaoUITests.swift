

//
//  LiangPiaoUITests.swift
//  LiangPiaoUITests
//
//  Created by Zhang on 05/02/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import XCTest

class LiangPiaoUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests
        self.testLogin()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLogin(){
        let app = XCUIApplication()
        app.tabBars.buttons["我的"].tap()
        app.tables.staticTexts["注册 / 登录"].tap()
        
        let textField = app.textFields["请输入手机号"]
        textField.tap()
        textField.typeText("18363899723")
        app.buttons["发验证码"].tap()
        
        let textField2 = app.textFields["验证码"]
        textField2.tap()
        textField2.tap()
        textField2.typeText("5604")
        app.buttons["立即登录"].tap()
    }
    
    func testShow(){
        XCUIApplication().tabBars.buttons["首页"].tap()
        
        
    }
    
}

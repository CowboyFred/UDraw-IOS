//
//  UDrawUITests.swift
//  UDrawUITests
//
//  Created by Denis Eltcov on 5/9/18.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest

class UDrawUITests: XCTestCase {
        
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
        // Use recording to get started writing UI tests.
        
        
        let app = XCUIApplication()
        let userNameTextField = app.textFields["User Name"]
        userNameTextField.tap()
        userNameTextField.typeText("123")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qq!111")
        app.buttons["Sign In"].tap()
        
        let brushButton = app.buttons["brush"]
        brushButton.tap()
        
        let lineButton = app.buttons["line"]
        lineButton.tap()
        lineButton.tap()
        
        let roundButton = app.buttons["round"]
        roundButton.tap()
        roundButton.tap()
        
        let rectButton = app.buttons["rect"]
        rectButton.tap()
        rectButton.tap()
        
        let hexButton = app.buttons["hex"]
        hexButton.tap()
        hexButton.tap()
        
        let octButton = app.buttons["oct"]
        octButton.tap()
        app.buttons["eraser"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.swipeDown()
        octButton.tap()
        brushButton.tap()
        app.buttons["palette"].tap()

        let redSlider = app.sliders["redSlider"]
        redSlider.adjust(toNormalizedSliderPosition: 0.5)
        
        let greenSlider = app.sliders["greenSlider"]
        greenSlider.adjust(toNormalizedSliderPosition: 0.5)
        
        let blueSlider = app.sliders["blueSlider"]
        blueSlider.adjust(toNormalizedSliderPosition: 0.5)
        
        let sizeSlider = app.sliders["sizeSlider"]
        sizeSlider.adjust(toNormalizedSliderPosition: 0.5)
        
        let opacitySlider = app.sliders["opacitySlider"]
        opacitySlider.adjust(toNormalizedSliderPosition: 0.5)
        
        app.buttons["Done"].tap()
        element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let clearButton = app.buttons["clear"]
        clearButton.tap()
        
        let areYouSureAlert = app.alerts["Are you sure?"]
        areYouSureAlert.buttons["Cancel"].tap()
        clearButton.tap()
        areYouSureAlert.buttons["Clear the canvas"].tap()

        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

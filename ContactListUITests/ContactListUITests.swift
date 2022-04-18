//
//  ContactListUITests.swift
//  ContactListUITests
//
//  Created by Martynov Evgeny on 31.03.21.
//

import XCTest

// MARK: - ContactListUITests

class ContactListUITests: XCTestCase {
    override func setUp() {
        // если зафейлится стопим
        continueAfterFailure = false
    }

    func testExample() {
        
        // экземпляр приложения + запуск
        let app = XCUIApplication()
        app.launch()
        
        // проверка на то что мы находимся на mainView
        XCTAssertTrue(app.isMainView)
        
        app.navigationBars["Persons"].buttons["Add"].tap()
        app.textFields["Name"].tap()
        
        let qKey = app/*@START_MENU_TOKEN@*/.keys["q"]/*[[".keyboards.keys[\"q\"]",".keys[\"q\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        qKey.tap()
        qKey.tap()
        qKey.tap()
        qKey.tap()
        qKey.tap()
        app.textFields["Surname"].tap()
        
        let wKey = app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        wKey.tap()
        wKey.tap()
        wKey.tap()
        wKey.tap()
        app.textFields["Phone"].tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        eKey.tap()
        eKey.tap()
        eKey.tap()
        eKey.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts[" Save"]/*[[".buttons[\" Save\"].staticTexts[\" Save\"]",".staticTexts[\" Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // проверка правильности новой записи
        XCTAssertTrue(app.tables.staticTexts["qqqqq"].exists)
    }

    // скорость запуска приложения
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    var isMainView: Bool {
        otherElements["mainView"].exists
    }
}

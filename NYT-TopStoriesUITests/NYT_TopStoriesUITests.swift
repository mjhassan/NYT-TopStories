//
//  NYT_TopStoriesUITests.swift
//  NYT-TopStoriesUITests
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import XCTest

class NYT_TopStoriesUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        app = nil
    }

    func testTopStoriesList() {
        app.launch()
        
        // check navigation bar title logo
        let titleLogo = app.navigationBars["NYT_TopStories.TopStoriesView"].staticTexts.containing(.image, identifier:"nyt_logo").element
        XCTAssertTrue(titleLogo.exists)
        
        // check body element
        let tableviewTable = app.tables["TableView"]
        XCTAssertTrue(tableviewTable.exists)
        
//        let searchField = tableviewTable.otherElements.element(boundBy: 0).otherElements["SearchField"]
//        XCTAssertTrue(searchField.exists)
//        searchField.typeText("US")
        
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(1)
        app.swipeUp()
        XCUIDevice.shared.orientation = .portrait
        sleep(1)
        app.swipeDown()
    }

    func testDetailView() {
        app.launch()
        
        let cell = app.tables["TableView"].cells.allElementsBoundByIndex[0]
        cell.tap()
        
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(1)
        let scrollView = app.scrollViews.allElementsBoundByIndex[0]
        scrollView.swipeUp()
        scrollView.swipeUp()
        scrollView.swipeDown()
        XCUIDevice.shared.orientation = .portrait
        sleep(1)
        scrollView.swipeDown()
        app.navigationBars.buttons["Back"].tap()
    }
    
    func testFullFlow() {
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  TopStoriesTests.swift
//  NYT-TopStoriesTests
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import XCTest
@testable import NYT_TopStories

class TopStoriesTests: XCTestCase {
    fileprivate var mockViewController: TopStoriesViewControllerDelegate!
    fileprivate var viewModel: TopStoriesProtocol!
    
    override func setUp() {
        mockViewController = MockTopStoriesViewController()
        viewModel = TopStoriesViewModel(bind: mockViewController)
    }

    override func tearDown() {
        mockViewController = nil
        viewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

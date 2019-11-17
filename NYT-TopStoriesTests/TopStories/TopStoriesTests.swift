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
    fileprivate var mockViewController: MockTopStoriesViewController!
    fileprivate var viewModel: TopStoriesProtocol!
    fileprivate var mockService: MockNYTService!
    
    override func setUp() {
        mockViewController  = MockTopStoriesViewController()
        mockService         = MockNYTService()
        viewModel           = TopStoriesViewModel(bind: mockViewController, service: mockService)
    }

    override func tearDown() {
        mockViewController  = nil
        viewModel           = nil
        mockService         = nil
    }

    func testInitialViewModel() {
        XCTAssertEqual(viewModel.articleCount, 0, "Articles should be empty as no data is loaded.")
        XCTAssertEqual(viewModel.filter.isEmpty, true, "Initial filter is empty.")
        XCTAssertNil(viewModel.article(at: 0), "Articles at zero should be nil.")
    }
    
    func testDataFetching() {
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.articleCount, mockService.articles.count)
        XCTAssertEqual(viewModel.filter.isEmpty, true)
        XCTAssertEqual(viewModel.article(at: 0), mockService.articles[0])
        
        XCTAssertTrue(mockViewController.calledWillStartFetchingData == 1, "Should invoke fetching start indicator for loading HUD")
        XCTAssertTrue(mockViewController.calledDidFinishFetchingData == 1, "Should update and refresh view.")
    }
    
    func testFailedDataFetching() {
        let mockError: CodableError = CodableError.custom("Test Error")
        mockService.mockError = mockError
        
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.articleCount, 0)
        XCTAssertNil(viewModel.article(at: 0))
        
        XCTAssertTrue(mockViewController.calledWillStartFetchingData == 1, "Should invoke fetching start indicator for loading HUD")
        XCTAssertTrue(mockViewController.calledDidFinishFetchingData == 0, "Should not update and refresh view.")
        XCTAssertTrue(mockViewController.calledDidFailedWithError, "Should invoke error passing delegate.")
        XCTAssertEqual(mockViewController.errorDescription, mockError.errorDescription)
    }
    
    func testDataSearchFilter() {
        let filter = "Trump"
        
        viewModel.fetchData()
        
        let expectedArticles = mockService.articles.filter { $0.title.lowercased().contains(filter.lowercased()) }
        
        viewModel.filter = filter
        
        XCTAssertTrue(mockViewController.calledDidFinishFetchingData == 2, "Should update and refresh view.")
        XCTAssertEqual(viewModel.articleCount, expectedArticles.count)
        XCTAssertEqual(viewModel.article(at: 0), expectedArticles[0])
    }
}

//
//  MockTopStoriesViewController.swift
//  NYT-TopStoriesTests
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation
@testable import NYT_TopStories

class MockTopStoriesViewController: TopStoriesViewControllerDelegate {
    public var calledWillStartFetchingData: Int = 0
    public var calledDidFinishFetchingData: Int = 0
    public var calledDidFailedWithError: Bool = false
    
    public var errorDescription: String? = nil
    
    func willStartFetchingData() {
        calledWillStartFetchingData += 1
    }
    
    func didFinishFetchingData() {
        calledDidFinishFetchingData += 1
    }
    
    func didFailedWithError(_ description: String) {
        errorDescription = description
        calledDidFailedWithError = true
    }
}

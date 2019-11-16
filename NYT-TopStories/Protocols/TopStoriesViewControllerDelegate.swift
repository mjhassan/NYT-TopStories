//
//  TopStoriesViewControllerDelegate.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

protocol TopStoriesViewControllerDelegate {
    func willStartFetchingData()
    func didFinishFetchingData()
    func didFailedWithError(_ description: String)
}

extension TopStoriesViewControllerDelegate {
    func willStartFetchingData() {}
    func didFailedWithError(_ description: String) {}
}

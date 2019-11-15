//
//  TopStoriesViewModel.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

class TopStoriesViewModel: TopStoriesProtocol {
    private let delegate: TopStoriesViewControllerDelegate?
    
    required init(bind delegate: TopStoriesViewControllerDelegate?) {
        self.delegate = delegate
    }
}

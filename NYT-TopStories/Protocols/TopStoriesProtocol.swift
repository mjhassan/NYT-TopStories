//
//  TopStoriesProtocol.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

protocol TopStoriesProtocol {
    var articleCount: Int { get }
    var filter: String { get set }
    
    init(bind delegate: TopStoriesViewControllerDelegate?, service: ServiceProtocol)
    
    func fetchData(force: Bool)
    func article(at index: Int) -> Article?
}

extension TopStoriesProtocol {
    init(bind delegate: TopStoriesViewControllerDelegate?) {
        self.init(bind: delegate, service: NYTService.shared)
    }
    
    func fetchData() { fetchData(force: false) }
}

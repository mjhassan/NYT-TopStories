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
    private let service: ServiceProtocol!
    
    private var articles: [Article] = []
    private var list: [Article] = []
    
    public var filter: String = "" {
        didSet {
            filterUser()
        }
    }
    
    public var articleCount: Int {
        return list.count
    }
    
    required init(bind delegate: TopStoriesViewControllerDelegate?, service: ServiceProtocol) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchData(force: Bool = false) {
        guard Reachability.isReachable == true else {
            delegate?.didFailedWithError("You are offline. Please try again later.")
            return
        }
        
        delegate?.willStartFetchingData()
        
        service.getTopStories { [weak self] result in
            switch result {
            case .success(let _articles):
                self?.articles = _articles
                self?.filter = ""
            case .failure(let err):
                self?.delegate?.didFailedWithError(err.errorDescription ?? "Unknown error occured")
            }
        }
    }
    
    func article(at index: Int) -> Article? {
        return (index >= 0 && index < articleCount) ? list[index]:nil
    }
    
    private func filterUser() {
        list.removeAll()
        list = filter.isEmpty ? articles:articles.filter { $0.title.lowercased().contains(filter.lowercased()) }
        
        self.delegate?.didFinishFetchingData()
    }
}

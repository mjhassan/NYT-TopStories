//
//  TopStoriesViewController.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController {

    private lazy var viewModel: TopStoriesProtocol = {
        let _viewModel = TopStoriesViewModel(bind: self)
        return _viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustAppearanceAndStyle()
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

fileprivate extension TopStoriesViewController {
    func adjustAppearanceAndStyle() {
        navigationItem.titleView = Banner.view()
        
    }
}

extension TopStoriesViewController: TopStoriesViewControllerDelegate {
    func willStartFetchingData() {
        print("Show progress hud")
    }
    
    func didFinishFetchingData() {
        print("data fetched")
    }
    
    func didFailedWithError(_ description: String) {
        fatalError(description)
    }
}

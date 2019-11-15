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
        // Do any additional setup after loading the view.
    }
}

extension TopStoriesViewController: TopStoriesViewControllerDelegate {
    
}

//
//  DetailViewProtocol.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/17/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

protocol DetailViewProtocol {
    var titleNavigation: String { get }
    var imageUrl: URL? { get }
    var title: String { get }
    var description: NSAttributedString { get }
    var articleUrl: URL { get }
    var author: String { get }
    var seeMoreRange: NSRange { get }
    
    init(article: Article)
    
    func getHeight(for width: Float) -> Float
}

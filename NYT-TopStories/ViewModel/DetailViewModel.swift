//
//  DetailViewModel.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/17/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewProtocol {
    private let article: Article!
    
    private var multimedia: Article.Multimedia? {
        return article.multimedias?.first(where: { $0.format == .superJumbo })
    }
    
    private let seeMore = "See More"
    
    var titleNavigation: String {
        return "\(article.section)\(article.subsection != nil ? " - \(article.subsection!)":"")"
    }
    
    var imageUrl: URL? {
        return self.multimedia?.url
    }
    
    var title: String {
        return article.title
    }
    
    var description: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(article.abstract) \(seeMore)")
        attributedString.addAttribute(.link, value: "\(articleUrl)", range: seeMoreRange)
        
        return attributedString
    }
    
    var articleUrl: URL {
        return article.url
    }
    
    var author: String {
        return article.author ?? ""
    }
    
    var seeMoreRange: NSRange {
        return NSRange(location: article.abstract.count, length: seeMore.count+1)
    }
    
    required init(article: Article) {
        self.article = article
    }
    
    func getHeight(for width: Float) -> Float {
        guard let _height = multimedia?.height, let _width = multimedia?.width else { return 0 }
        
        return width / Float(_width) * Float(_height)
    }
}

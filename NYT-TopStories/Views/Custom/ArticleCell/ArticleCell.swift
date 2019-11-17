//
//  ArticleCell.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let identifier: String = String(describing: ArticleCell.self)
    static var nib: UINib {
        return UINib(nibName: ArticleCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    
    private let placeholder = UIImage(named: "placeholder")
    
    var article: Article? {
        didSet {
            guard let _article = article else { return }
            
            titleLabel?.text = _article.title
            abstractLabel?.text = _article.author
            
            imgView?.image = placeholder
            titleLeadingConstraint.constant = _article.thumbURL == nil ? 8:91
            
            invoke(onThread: DispatchQueue.main) {
                if let url = _article.thumbURL {
                    self.imgView.isHidden = false
                    self.imgView?.hnk_setImageFromURL(url)
                } else {
                    self.imgView.isHidden = true
                }
            }
        }
    }
}

//
//  ArticleCell.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let identifier: String = String(describing: self)
    
    var article: Article? {
        didSet {
            textLabel?.text = article?.title
            detailTextLabel?.text = article?.abstract
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

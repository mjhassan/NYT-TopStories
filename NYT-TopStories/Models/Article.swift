//
//  Article.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

struct Article: Codable {
    enum Format: String, Codable {
        case standardThumbnail      = "Standard Thumbnail"
        case largeThumbnail         = "thumbLarge"
        case normal                 = "Normal"
        case mediumThreeByTwo210    = "mediumThreeByTwo210"
        case superJumbo             = "superJumbo"
    }
    
    struct Multimedia: Codable {
        let url: URL
        let format: Format
        let caption: String?
        let copyright: String?
        
    }
    
    let section: String
    let subsection: String?
    let title: String
    let abstract: String
    let url: URL
    let author: String?
    let date: Date?
    let multimedias: [Multimedia]?
    
    var thumbURL: URL? {
        return multimedias?.first(where: { $0.format == .superJumbo })?.url
    }
    
    enum CodingKeys: String, CodingKey {
        case author         = "byline"
        case date           = "published_date"
        case multimedias    = "multimedia"
        case section, subsection, title, abstract, url
    }
    
}

struct Section: Codable {
    let results: [Article]
}

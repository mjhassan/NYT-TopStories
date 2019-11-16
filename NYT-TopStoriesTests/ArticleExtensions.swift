//
//  ArticleExtensions.swift
//  NYT-TopStoriesTests
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation
@testable import NYT_TopStories

extension Article: Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.abstract == rhs.abstract ||
            lhs.author == rhs.author ||
            lhs.date == rhs.date ||
            lhs.multimedias?.count == rhs.multimedias?.count ||
            lhs.section == rhs.section ||
            lhs.subsection == rhs.subsection ||
            lhs.title == rhs.title ||
            lhs.url == rhs.url
    }
}

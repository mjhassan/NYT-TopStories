//
//  DetailViewModelTests.swift
//  NYT-TopStoriesTests
//
//  Created by Jahid Hassan on 11/17/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import XCTest
@testable import NYT_TopStories

class DetailViewModelTests: XCTestCase {
    fileprivate var viewModel: DetailViewProtocol!
    fileprivate let mockArticle: Article = Article(section: "U.S.",
                                                   subsection: "Politics",
                                                   title: "Impeachment Hearings",
                                                   abstract: "As the former ambassador to Ukraine testified about her shock",
                                                   url: URL(fileURLWithPath: "https://nyti.ms/33QsUIJ"),
                                                   author: "By PETER BAKER and MICHAEL D. SHEAR",
                                                   date: Date(),
                                                   multimedias: nil)
    override func setUp() {
        viewModel = DetailViewModel(article: mockArticle)
    }

    override func tearDown() {
        viewModel = nil
    }

    func testViewModel() {
        var extected = "\(mockArticle.section)\(mockArticle.subsection != nil ? " - \(mockArticle.subsection!)":"")"
        XCTAssertEqual(viewModel.titleNavigation, extected)
        
        XCTAssertNil(viewModel.imageUrl)
        
        extected = mockArticle.title
        XCTAssertEqual(viewModel.title, extected)
        
        let seeMore = "See More"
        let extectedAttribute = NSMutableAttributedString(string: "\(mockArticle.abstract) \(seeMore)")
        extectedAttribute.addAttribute(.link, value: "\(mockArticle.url)", range: viewModel.seeMoreRange)
        XCTAssertEqual(viewModel.description, extectedAttribute)
        
        XCTAssertEqual(viewModel.author, mockArticle.author)
        
        let width: Float = 300
        XCTAssertEqual(viewModel.getHeight(for: width), 0) // multimedia is empty
    }

}

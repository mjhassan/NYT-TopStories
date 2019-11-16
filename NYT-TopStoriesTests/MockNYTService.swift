//
//  MockNYTService.swift
//  NYT-TopStoriesTests
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation
@testable import NYT_TopStories

class MockNYTService: ServiceProtocol {
    static var shared: ServiceProtocol = MockNYTService()
    
    var articles: [Article] = []
    var mockError: CodableError? = nil
    
    func getTopStories(_ completion: @escaping (Result<[Article], CodableError>) -> Void) {
        // for testing errors
        if mockError != nil {
            completion(.failure(mockError!))
            return
        }
        
        // mocking service call
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "top_stories_home", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let section =  try decoder.decode(Section.self, from: data)
            articles = section.results
            completion(.success(section.results))
        } catch {
            completion(.failure(.custom(error.localizedDescription)))
        }
    }
}

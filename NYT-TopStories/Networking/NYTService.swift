//
//  NYTService.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

enum NYT_API {
    case articles(source: String)
    
    private static var baseURL = URLComponents(string: "https://api.nytimes.com/")
    private static let token: String = "XTLmhYCVbqFX6wD72IBA20sDN9YNDEty"
    
    var url: URL? {
        switch self {
        case .articles(let source):
            NYT_API.baseURL?.path = "/svc/topstories/v2/\(source).json"
            NYT_API.baseURL?.queryItems = [URLQueryItem(name: "api-key", value: NYT_API.token)]
            
            guard let url = NYT_API.baseURL?.url else { return nil }
            return url
            
        default:
            fatalError("TBD")
        }
    }
}

class NYTService: ServiceProtocol {
    static let shared: ServiceProtocol = NYTService()
    
    func getTopStories(_ completion: @escaping (Result<[Article], CodableError>) -> Void) {
        getNewsfeed(source: "home", completion)
    }
    
    private func getNewsfeed(source: String, _ completion: @escaping (Result<[Article], CodableError>) -> Void) {
        guard let newsUrl = NYT_API.articles(source: source).url else {
            completion(.failure(.unknown))
            return
        }
        
        let newsRequest = URLRequest(url: newsUrl)
        let session = URLSession.shared
        
        session.dataTask(with: newsRequest) { (data, _, error) in
            guard error == nil, let data = data else {
                completion(.failure(.custom(error!.localizedDescription)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let section =  try decoder.decode(Section.self, from: data)
                completion(.success(section.results))
            } catch {
                completion(.failure(.custom(error.localizedDescription)))
            } 
        }.resume()
    }
}

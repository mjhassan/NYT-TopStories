//
//  ServiceProtocol.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    static var shared: ServiceProtocol { get }
    
    func getTopStories(_ completion: @escaping (Result<[Article], CodableError>) -> Void)
}

//
//  CodableError.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

enum CodableError: Error, LocalizedError {
    case unknown
    case custom (String)
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown error ccured", comment: "")
        case .custom(let context):
            return NSLocalizedString(context, comment: "")
        }
    }
}

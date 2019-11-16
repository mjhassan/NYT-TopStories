//
//  Banner.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class Banner: UIView {
    static var view: UIView {
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

//
//  AsyncFunctions.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/16/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

func invoke(after: Double = 0.0,
            onThread: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default),
            callback: @escaping ()->())
{
    onThread.asyncAfter(deadline: .now()+after) {
        callback()
    }
}

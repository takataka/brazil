//
//  Helpers.swift
//  BrazilIdeas
//
//  Created by Mike Rotondo on 8/24/14.
//  Copyright (c) 2014 Taka Taka. All rights reserved.
//

import Foundation

func randFloat() -> CGFloat {
    return CGFloat(arc4random_uniform(10000)) / 10000
}
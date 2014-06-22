//
//  Factorial.swift
//  Binomial
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

struct Factorial {
    
    let n:Int
    
    init(_ n:Int)
    {
        self.n = n
    }
    
    var factors:Factors
    {
        return Factors(1...n)
    }
}

extension Double {
    init(_ v: Factorial) {
        self = Double(v.factors)
    }
}
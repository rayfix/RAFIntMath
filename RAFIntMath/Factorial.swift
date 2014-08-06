//
//  Factorial.swift
//  Binomial
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

public struct Factorial {
    
    public let n:Int
    
    public init(_ n:Int)
    {
        self.n = n
    }
    
    public var factors:Factors
    {
        return n == 0 ? Factors(1) : Factors(1...n)
    }
}

public extension Double {
    public init(_ v: Factorial) {
        self = Double(v.factors)
    }
}
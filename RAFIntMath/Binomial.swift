//
//  Binomial.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

public struct Binomial {
    public var n:Int
    public var choose:Int
    
    // private
    func _toDouble() -> Double {
        var num = Factorial(n).factors
        var den = Factorial(choose).factors * Factorial(n-choose).factors
        reduce(&num, &den)
        return Double(num) / Double(den)
    }
    
    public init(n:Int, choose:Int) {
        self.n = n
        self.choose = choose
    }
    
}

public extension Double {
    public init(_ v: Binomial) {
        self = v._toDouble()
    }
}

public func /(num:Binomial, den:Binomial) -> Rational {
    var n = Factorial(num.n).factors * Factorial(den.choose).factors * Factorial(den.n - den.choose).factors
    var d = Factorial(den.n).factors * Factorial(num.choose).factors * Factorial(num.n - num.choose).factors
    reduce(&n, &d)
    return Rational(Int(n),Int(d))
}
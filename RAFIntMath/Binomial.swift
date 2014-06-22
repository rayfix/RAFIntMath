//
//  Binomial.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

struct Binomial {
    var n:Int
    var choose:Int
    
    // private
    func _toDouble() -> Double {
        var num = Factorial(n).factors
        var den = Factorial(choose).factors * Factorial(n-choose).factors
        cancel(&num, &den)
        return Double(num) / Double(den)
    }
}

extension Double {
    init(_ v: Binomial) {
        self = v._toDouble()
    }
}

func /(num:Binomial, den:Binomial) -> Rational {
    var n = Factorial(num.n).factors * Factorial(den.choose).factors * Factorial(den.n - den.choose).factors
    var d = Factorial(den.n).factors * Factorial(num.choose).factors * Factorial(num.n - num.choose).factors
    cancel(&n, &d)
    return Rational(Int(n),Int(d))
}
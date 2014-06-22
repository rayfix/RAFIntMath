//
//  Factors.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

struct Factors : Printable
{
    var _factors:Dictionary<Int,Int> = [:]
    
    init(_ f:Int, convertToPrime:Bool = false)
    {
        _factors[f] = 1
        if (convertToPrime) {
            makePrime()
        }
    }
    
    init(_ range:Range<Int>)
    {
        for r in range {
            if (r != 1) {
                _factors[r] = 1
            }
        }
    }
    
    var description:String
    {
        var desc = ""
        var addComma = false
        for (factor,count) in _factors {
            if (addComma) {
                desc += ", "
            }
            desc += "\(factor)x\(count)"
            addComma = true
        }
        return desc
    }
    
    subscript(index:Int) -> Int? {
        get {
            return _factors[index]
        }
        set(newValue) {
            _factors[index] = newValue
        }
    }
    
    var count:Int
    {
        return _factors.count
    }
    
    func _primeFactors(input:Int) -> Array<Int>
    {
        var n = input
        var answer:Array<Int> = []
        var z = 2
        
        while z * z <= n {
            if (n % z == 0) {
                answer.append(z)
                n /= z
            }
            else {
                ++z
            }
        }
        if n > 1 {
            answer.append(n)
        }
        return answer
    }
    
    func primeFactors() -> Dictionary<Int,Int>
    {
        var primeFactors:Dictionary<Int,Int> = [:]
        
        for (k,v) in _factors {
            let primes = _primeFactors(k)
            for p in primes {
                if let current = primeFactors[p] {
                    primeFactors[p] = current + v
                }
                else {
                    primeFactors[p] = v
                }
            }
        }
        return primeFactors
    }
    
    mutating func makePrime()
    {
        _factors = primeFactors()
    }
}

func cancel(inout f1:Factors, inout f2:Factors)
{
    var swapped = false
    if (f1.count > f2.count) {
        swap(&f1, &f2)
        swapped = true
    }
    
    for (k,v1) in f1._factors {
        if let v2 = f2._factors[k] {
            if (v1 == v2) {
                f1._factors.removeValueForKey(k)
                f2._factors.removeValueForKey(k)
            }
            else if (v1 > v2) {
                f1._factors[k] = v1-v2
                f2._factors.removeValueForKey(k)
            }
            else {
                f1._factors.removeValueForKey(k)
                f2._factors[k] = v2-v1
            }
        }
    }
    if (swapped) {
        swap(&f1, &f2)
    }
}

func *(lhs:Factors, rhs:Factors) -> Factors
{
    var (fewest, most) = lhs.count < rhs.count ? (lhs, rhs) : (rhs, lhs)
    for (factor,count) in fewest._factors {
        if let currentCount = most._factors[factor] {
            most._factors[factor] = currentCount + count
        }
        else {
            most._factors[factor] = 1
        }
    }
    return most
}

extension Int {
    init(_ v:Factors) {
        var accum = 1
        for (factor, count) in v._factors
        {
            for i in 0..count {
                accum *= factor
            }
        }
        self = accum
    }
}

extension Double {
    init(_ v: Factors) {
        var accum:Double = 1
        for (factor, count) in v._factors
        {
            accum *= pow(Double(factor), Double(count))
        }
        self = accum
    }
}

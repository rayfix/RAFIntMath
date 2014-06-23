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
    
    init(_ input:Int, convertToPrime:Bool = false)
    {
        if (convertToPrime) {
            let primes = Factors.primes(input)
            for p in primes {
                let count = _factors[p] ?  _factors[p]! : 0
                _factors[p] = count + 1
            }
        }
        else {
            _factors[input] = 1
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
    
    static func primes(input:Int) -> Array<Int>
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
    
    mutating func add(factor:Int, count:Int = 1)
    {
        if let current = _factors[factor] {
            self._factors[factor] = current + count
        }
        else {
            self._factors[factor] = count
        }
    }
    
    func primeFactors() -> Dictionary<Int,Int>
    {
        var primeFactors:Dictionary<Int,Int> = [:]
        
        for (factor,count) in _factors {
            let primes = Factors.primes(factor)
            for p in primes {
                let current = primeFactors[p] ? primeFactors[p]! : 0
                primeFactors[p] = current + count
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
            most._factors[factor] = count
        }
    }
    return most
}

extension Int {
    init(_ v:Factors) {
        var answer = 1
        for (base, power) in v._factors
        {
            for _ in 0..power {
                answer *= base
            }
        }
        self = answer
    }
}

extension Double {
    init(_ v: Factors) {
        var answer:Double = 1
        for (base, power) in v._factors
        {
            answer *= pow(Double(base), Double(power))
        }
        self = answer
    }
}

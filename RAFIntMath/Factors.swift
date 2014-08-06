//
//  Factors.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

public
struct Factors : Printable, SequenceType
{
    private var factors:[Int:Int] = [:]
    
    public init(_ input:Int, convertToPrime:Bool = false)
    {
        if (convertToPrime) {
            for p in Factors.primes(input) {
                add(p)
            }
        }
        else {
            factors[input] = 1
        }
    }
    
    public init(_ range:Range<Int>)
    {
        for r in range {
            if (r != 1) {
                factors[r] = 1
            }
        }
    }
    
    public var description:String
    {
        var desc = ""
        var addComma = false
        let arr = Array(factors.keys)
        let sortedFactors = sorted(arr,<)
            
        for factor in sortedFactors {
            let power = factors[factor]!
            if (addComma) {
                desc += " * "
            }
            desc += power != 1 ? "\(factor)^\(power)" : "\(factor)"
            addComma = true
        }
        return desc
    }
    
    public func generate() -> FactorGenerator {
        return FactorGenerator(factorsDictionary: factors)
    }
    
    public subscript(index:Int) -> Int? {
        get {
            return factors[index]
        }
        set(newValue) {
            factors[index] = newValue
        }
    }
    
    public var count:Int
    {
        return factors.count
    }
    
    public static func primes(input:Int) -> [Int]
    {
        var n = input
        var answer:[Int] = []
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
    
    public mutating func add(factor:Int, count:Int = 1)
    {
        if (factors[factor] != nil) {
            factors[factor]! += count
        }
        else {
            factors[factor] = count
        }
        
    }
    
    public func primeFactors() -> [Int:Int]
    {
        var primeFactors:[Int:Int] = [:]
        
        for (factor,count) in factors {
            let primes = Factors.primes(factor)
            for p in primes {
                let current = primeFactors[p] != nil ? primeFactors[p]! : 0
                primeFactors[p] = current + count
            }
        }
        return primeFactors
    }
    
    public mutating func makePrime()
    {
        factors = primeFactors()
    }
}

public func reduce(inout f1:Factors, inout f2:Factors)
{
    var swapped = false
    if (f1.count > f2.count) {
        swap(&f1, &f2)
        swapped = true
    }
    
    for (k,v1) in f1.factors {
        if let v2 = f2.factors[k] {
            if (v1 == v2) {
                f1.factors.removeValueForKey(k)
                f2.factors.removeValueForKey(k)
            }
            else if (v1 > v2) {
                f1.factors[k] = v1-v2
                f2.factors.removeValueForKey(k)
            }
            else {
                f1.factors.removeValueForKey(k)
                f2.factors[k] = v2-v1
            }
        }
    }
    if (swapped) {
        swap(&f1, &f2)
    }
}

public func *(lhs:Factors, rhs:Factors) -> Factors
{
    var (fewest, most) = lhs.count < rhs.count ? (lhs, rhs) : (rhs, lhs)
    for (factor,count) in fewest.factors {
        if let currentCount = most.factors[factor] {
            most.factors[factor] = currentCount + count
        }
        else {
            most.factors[factor] = count
        }
    }
    return most
}

public extension Int {
    public init(_ v:Factors) {
        var answer = 1
        for (base, power) in v.factors
        {
            for _ in 0..<power {
                answer *= base
            }
        }
        self = answer
    }
}

public extension Double {
    public init(_ v: Factors) {
        var answer:Double = 1
        for (base, power) in v.factors
        {
            answer *= pow(Double(base), Double(power))
        }
        self = answer
    }
}

public struct FactorGenerator : GeneratorType
{
    init (factorsDictionary:[Int:Int])
    {
        generator = factorsDictionary.generate()
    }
    
    mutating public func next() -> (Int,Int)?
    {
        return generator.next()
    }
    
    var generator:Dictionary<Int,Int>.Generator
}

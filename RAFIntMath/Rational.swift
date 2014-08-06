//
//  Rational.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

public struct Rational : Printable, Comparable, Hashable
{
    public let numerator:Int
    public let denominator:Int
    
    public init(_ v:Int)
    {
        self.init(v,1)
    }
    
    public init(_ n:Int, _ d:Int)
    {
        self.numerator = n
        self.denominator = d
    }
    
    public var isZero : Bool
    {
        return !isNaN && numerator == 0
    }
    
    public var isNaN : Bool
    {
        return denominator == 0
    }
    
    public var reciprocal: Rational
    {
        return Rational(denominator, numerator)
    }
    
    public var wholePart:Int
    {
        return numerator / denominator
    }
    
    public var remainder:Int
    {
        return numerator % denominator
    }
    
    public var description:String
    {
        if (isNaN) {
            return "NaN"
        }
        else if (self.denominator == 1) {
            return "\(numerator)"
        }
        else {
            return "\(numerator)/\(denominator)"
        }
    }
    
    static func gcd(var a:Int, var _ b:Int) -> Int
    {
        var t:Int
        while (b != 0) {
            t = b
            b = a % b
            a = t
        }
        return a
    }
    
    public func reduced() -> Rational
    {
        if (isZero) {
            return Rational(0,1)
        }
        else if (isNaN) {
            return Rational(1,0)
        }
        else if (denominator != 1) {
            let x = Rational.gcd(numerator, denominator)
            return Rational(numerator/x, denominator/x)
        }
        return self
    }
    
    public var hashValue: Int
    {
        return Double(self).hashValue
    }
}

public func ==(a: Rational, b: Rational) -> Bool
{
    let lhs = a.reduced()
    let rhs = b.reduced()
    
    return lhs.numerator == rhs.numerator &&
        lhs.denominator == rhs.denominator
}

public func <(lhs: Rational, rhs: Rational) -> Bool
{
    return Double(lhs) < Double(rhs)
}

public func +(lhs:Rational, rhs:Rational) -> Rational
{
    return Rational(lhs.numerator * rhs.denominator   +
        rhs.numerator * lhs.denominator,
        lhs.denominator * rhs.denominator).reduced()
}

public func -(lhs:Rational, rhs:Rational) -> Rational
{
    return lhs + (-rhs)
}

public prefix func -(a: Rational) -> Rational {
    return Rational(-a.numerator, a.denominator)
}

public func *(a: Rational, b: Rational) -> Rational
{
    return Rational(a.numerator*b.numerator,a.denominator*b.denominator)
}

public func /(a: Rational, b: Rational) -> Rational
{
    return a * b.reciprocal;
}

public extension Double {
    init(_ v:Rational)
    {
        self = Double(v.numerator) / Double(v.denominator)
    }
}

//
//  Rational.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import Foundation

struct Rational : Printable, Comparable, Hashable
{
    let numerator:Int
    let denominator:Int
    
    init(_ v:Int)
    {
        self.init(v,1)
    }
    
    init(_ n:Int, _ d:Int)
    {
        self.numerator = n
        self.denominator = d
    }
    
    var isZero : Bool
    {
        return !isNaN && numerator == 0
    }
    
    var isNaN : Bool
    {
        return denominator == 0
    }
    
    var reciprocal: Rational
    {
        return Rational(denominator, numerator)
    }
    
    var wholePart:Int
    {
        return numerator / denominator
    }
    
    var remainder:Int
    {
        return numerator % denominator
    }
    
    var description:String
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
    
    func reduced() -> Rational
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
    
    var hashValue: Int
    {
        return Double(self).hashValue
    }
}

func ==(a: Rational, b: Rational) -> Bool
{
    let lhs = a.reduced()
    let rhs = b.reduced()
    
    return lhs.numerator == rhs.numerator &&
        lhs.denominator == rhs.denominator
}

func <(lhs: Rational, rhs: Rational) -> Bool
{
    return Double(lhs) < Double(rhs)
}

func +(lhs:Rational, rhs:Rational) -> Rational
{
    return Rational(lhs.numerator * rhs.denominator   +
        rhs.numerator * lhs.denominator,
        lhs.denominator * rhs.denominator)
}

func -(lhs:Rational, rhs:Rational) -> Rational
{
    return lhs + (-rhs)
}

@prefix func -(a: Rational) -> Rational {
    return Rational(-a.numerator, a.denominator)
}

func *(a: Rational, b: Rational) -> Rational
{
    return Rational(a.numerator*b.numerator,a.denominator*b.denominator)
}

func /(a: Rational, b: Rational) -> Rational
{
    return a * b.reciprocal;
}

extension Double {
    init(_ v:Rational)
    {
        self = Double(v.numerator) / Double(v.denominator)
    }
}

//
//  FactorsTests.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import XCTest
import RAFIntMath


class FactorsTests: XCTestCase {

    func testFactors()
    {
        let f = Factors(10)
        XCTAssertEqual(f[10]!, 1)
        XCTAssertEqual(f.count, 1)
        XCTAssertEqual(Int(f), 10)
    }
    
    func testFactorsMakePrime()
    {
        var f = Factors(10)
        f.makePrime()
        XCTAssertEqual(f[5]!, 1)
        XCTAssertEqual(f[2]!, 1)
        XCTAssertEqual(f.count, 2)
    }
    
    func testFactorsMakePrime2()
    {
        let f = Factors(10, convertToPrime:true)
        XCTAssertEqual(f[5]!, 1)
        XCTAssertEqual(f[2]!, 1)
        XCTAssertEqual(f.count, 2)
    }
    
    func testFactorsMakePrime3()
    {
        let f = Factors(8, convertToPrime:true)
        XCTAssertEqual(f[2]!, 3)
        XCTAssertEqual(f.count, 1)
    }
    
    func testFactorsMakePrime4()
    {
        let f = Factors(8*3*5*7*43, convertToPrime:true)
        XCTAssertEqual(f[2]!, 3)
        XCTAssertEqual(f[3]!, 1)
        XCTAssertEqual(f[5]!, 1)
        XCTAssertEqual(f[7]!, 1)
        XCTAssertEqual(f[43]!, 1)
        XCTAssertEqual(f.count, 5)
    }
    
    func testFactorsMultiply()
    {
        let f = Factors(10, convertToPrime:true)
        let f2 = f * f
        XCTAssertEqual(f2[5]!, 2)
        XCTAssertEqual(f2[2]!, 2)
        XCTAssertEqual(f2.count, 2)
    }
    
    func testFactorsToInt()
    {
        let f = Factors(20, convertToPrime:true)
        XCTAssertEqual(Int(f), 20)
    }
    
    func testFactorsMultiply2()
    {
        let f1 = Factors(100, convertToPrime:true)
        let f2 = Factors(200, convertToPrime:true)
        let f = f1 * f2
        XCTAssertEqual(Int(f), 20_000)
    }
    
    func testFactorsMultiply3()
    {
        let f1 = Factors(100)
        let f2 = Factors(1024, convertToPrime:true)
        let f = f1 * f2
        XCTAssertEqual(Int(f), 102_400)
    }
    
    func testFactorsCancel()
    {
        var f1 = Factors(100, convertToPrime:true)
        var f2 = Factors(200)
        cancel(&f1, &f2)
        XCTAssertEqual(Rational(1,2), Rational(Int(f1),Int(f2)))
    }
    
    func testConvertToInt()
    {
        let f100 = Factors(100)
        let f1024 = Factors(1024, convertToPrime:true)
        XCTAssertEqual(Int(f100), 100)
        XCTAssertEqual(Int(f1024), 1024)
        XCTAssertEqual(Int(f100*f1024), 102_400)
    }
    
    func testConvertToDouble()
    {
        let f100 = Factors(100)
        let f1024 = Factors(1024, convertToPrime:true)
        XCTAssertEqual(Double(f100), 100.0)
        XCTAssertEqual(Double(f1024), 1024.0)
        XCTAssertEqual(Double(f100*f1024), 102_400.0)
    }

    func testPrimeFactors()
    {
        let expected = [2,3,3,5,7,11,13]
        let factors = Factors.primes(2*3*3*5*7*11*13)
        XCTAssertTrue(factors == expected)
    }
}

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
    
    func testFactorsCancel()
    {
        var f1 = Factors(100, convertToPrime:true)
        var f2 = Factors(200)
        cancel(&f1, &f2)
        XCTAssertEqual(Rational(1,2), Rational(Int(f1),Int(f2)))
        
    }
}

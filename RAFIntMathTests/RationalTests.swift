//
//  RationalTests.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import XCTest
import RAFIntMath

class RationalTests: XCTestCase {
    
    func testRational()
    {
        let r = Rational(1204,423)
        XCTAssertEqual(r.numerator, 1204)
        XCTAssertEqual(r.denominator, 423)
        XCTAssertEqual(r.denominator, 423)
    }
    
    func testRationalWholeRemainder()
    {
        XCTAssertEqual(Rational(10,2).wholePart, 5)
        XCTAssertEqual(Rational(10,2).remainder, 0)
    }
    
    func testRationalNaN()
    {
        XCTAssertTrue(Rational(10,0).isNaN)
        XCTAssertFalse(Rational(10,1).isNaN)
    }
    
    func testRationalEquality()
    {
        XCTAssertEqual(Rational(10,2), Rational(10,2))
        XCTAssertEqual(Rational(10,2), Rational(20,4))
        XCTAssertEqual(Rational(10,2), Rational(5,1))
        XCTAssertNotEqual(Rational(10,2), Rational(5,2))
    }
    
    func testReciprocal()
    {
        XCTAssertEqual(Rational(1,8).reciprocal, Rational(8))
        XCTAssertEqual(Rational(8).reciprocal, Rational(1,8))
        XCTAssertEqual(Rational(1,8).reciprocal, Rational(16,2))
    }
    
    func testRationalMultiplication()
    {
        var r = Rational(8)
        var a = r * r.reciprocal
        XCTAssertEqual(a, Rational(1))
        
        XCTAssertEqual(Rational(1,8) * Rational(8,1), Rational(1))
    }
    
    func testRationalSubtraction()
    {
        let r = Rational(8)
        let a = r - r
        XCTAssert(a.isZero)
        let a2  = r - r * Rational(3)
        XCTAssertEqual(a2, Rational(-2)*r)
    }
    
    func testRationalAddition()
    {
        let r = Rational(100) + Rational(200)
        XCTAssertEqual(r, Rational(300))
    }
    
    func testRationalAddition2()
    {
        let r = Rational(10,8) + Rational(3,12)
        XCTAssertEqual(r, Rational(3,2))
    }
    
    func testRationalAddition3()
    {
        let r = Rational(10,20) + Rational(2,3) + Rational(1,3) + Rational(1,2)
        XCTAssertEqual(Rational(2), r)
    }
    
    func testComparable()
    {
        XCTAssertTrue(Rational(1,3) < Rational(1,2))
    }
    
    func testSort()
    {
        let input = [Rational(1,2), Rational(3,2), Rational(-6,2),Rational(-1,2),Rational(78,160)]
        let sorted = sort(input) { $0 < $1 }
        let expected = [Rational(-6,2),Rational(-1,2),Rational(78,160),Rational(1,2),Rational(3,2)]
        for (index, value) in enumerate(sorted) {
            XCTAssertEqual(value, expected[index])
        }

    }
}

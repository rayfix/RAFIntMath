//
//  BinomialTests.swift
//  BinomialTests
//
//  Created by Ray Fix on 6/19/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import XCTest
import RAFIntMath

let eps = 1e-10


class BinomialTests: XCTestCase {
    
    func testBinomial()
    {
        let b = Binomial(n: 10,choose: 2)
        XCTAssertEqualWithAccuracy(Double(b), 45.0, eps)
    }
    
    func testBinomial2()
    {
        let b = Binomial(n: 10, choose: 0)
        XCTAssertEqualWithAccuracy(Double(b), 1.0, eps)
    }
    
    func testBinomial3()
    {
        let b = Binomial(n: 10, choose: 10)
        XCTAssertEqualWithAccuracy(Double(b), 1.0, eps)
    }
    
    func testBinomial4()
    {
        let b = Binomial(n: 10, choose: 8)
        XCTAssertEqualWithAccuracy(Double(b), 45.0, eps)
    }
    
    func testPrintRational()
    {
        let foo = Rational(10,12)
        XCTAssertEqualObjects("\(foo)", "10/12")
    }
    
    
    func testPokerAce() {
        let handsWithAceOfDiamonds = Binomial(n: 51, choose: 4)
        let allHands = Binomial(n: 52, choose: 5)
        
        let p = Double(handsWithAceOfDiamonds) / Double(allHands)
        
        XCTAssertEqualWithAccuracy(p, 5.0/52.0, eps)
        
    }
    
    func testPokerAceOfDiamonds()
    {
        let handsWithAceOfDiamonds = Binomial(n: 51, choose: 4)
        let allPossibleHands = Binomial(n: 52, choose: 5)
        
        let probabilityOfAceOfDiamonds = handsWithAceOfDiamonds / allPossibleHands
        
        XCTAssertEqual(probabilityOfAceOfDiamonds, Rational(5,52))
        
        let probabilityOfNoAceOfDiamonds = Rational(1) - probabilityOfAceOfDiamonds
        
        XCTAssertEqual(probabilityOfNoAceOfDiamonds, Rational(47,52))
    }
}

//
//  FactorialTests.swift
//
//  Created by Ray Fix on 6/21/14.
//  Copyright (c) 2014 Pelfunc, Inc. All rights reserved.
//

import XCTest
import RAFIntMath

class FactorialTests: XCTestCase {

    func testBasicFactorials()
    {
        XCTAssertEqualWithAccuracy(Double(Factorial(0)), 1.0, eps)
        XCTAssertEqualWithAccuracy(Double(Factorial(1)), 1.0, eps)
        XCTAssertEqualWithAccuracy(Double(Factorial(2)), 2.0, eps)
        XCTAssertEqualWithAccuracy(Double(Factorial(3)), 6.0, eps)
    }
    
    func testMultiplyFactorials()
    {
        XCTAssertEqualWithAccuracy(Double(Factorial(3))*Double(Factorial(3)), 36.0, eps)
    }


}

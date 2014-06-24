
# RAFIntMath

RAFIntMath is a simple integer based math library.  It was developed
to compute exact probabilities.  For example, you can compute the probability
of getting the ace of diamonds in your poker hand.  It turns out that 
it is 5/52.

```swift
    func testPokerAceOfDiamonds()
    {
        let handsWithAceOfDiamonds = Binomial(n: 51, choose: 4)
        let allPossibleHands = Binomial(n: 52, choose: 5)
        
        let probabilityOfAceOfDiamonds = handsWithAceOfDiamonds / allPossibleHands
        
        XCTAssertEqual(probabilityOfAceOfDiamonds, Rational(5,52))
        
        let probabilityOfNoAceOfDiamonds = Rational(1) - probabilityOfAceOfDiamonds
        
        XCTAssertEqual(probabilityOfNoAceOfDiamonds, Rational(47,52))
    }
```


//
//  SparkAnimationRepeat.swift
//  SparkCommon
//
//  Created by robin.lemaire on 20/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCommon

class SparkAnimationRepeatTests: XCTestCase {

    func testOnceRepeat() {
        let animation = SparkAnimationRepeat.once
        XCTAssertFalse(animation.canContinue(counter: 0))
        XCTAssertFalse(animation.canContinue(counter: 1))
    }

    func testLimitedRepeat() {
        let animation = SparkAnimationRepeat.limited(3)
        XCTAssertTrue(animation.canContinue(counter: 0))
        XCTAssertTrue(animation.canContinue(counter: 1))
        XCTAssertTrue(animation.canContinue(counter: 2))
        XCTAssertFalse(animation.canContinue(counter: 3))
        XCTAssertFalse(animation.canContinue(counter: 4))
    }

    func testUnlimitedRepeat() {
        let animation = SparkAnimationRepeat.unlimited
        XCTAssertTrue(animation.canContinue(counter: 0))
        XCTAssertTrue(animation.canContinue(counter: 100))
        XCTAssertTrue(animation.canContinue(counter: 1000))
    }
}

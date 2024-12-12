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
        XCTAssertFalse(animation.canContinue(count: 0))
        XCTAssertFalse(animation.canContinue(count: 1))
    }

    func testLimitedRepeat() {
        let animation = SparkAnimationRepeat.limited(3)
        XCTAssertTrue(animation.canContinue(count: 0))
        XCTAssertTrue(animation.canContinue(count: 1))
        XCTAssertTrue(animation.canContinue(count: 2))
        XCTAssertFalse(animation.canContinue(count: 3))
        XCTAssertFalse(animation.canContinue(count: 4))
    }

    func testUnlimitedRepeat() {
        let animation = SparkAnimationRepeat.unlimited
        XCTAssertTrue(animation.canContinue(count: 0))
        XCTAssertTrue(animation.canContinue(count: 100))
        XCTAssertTrue(animation.canContinue(count: 1000))
    }
}

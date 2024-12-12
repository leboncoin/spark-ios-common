//
//  BellConstantsTests.swift
//  SparkCommon
//
//  Created by robin.lemaire on 25/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCommon

class BellConstantsTests: XCTestCase {

    func testRotationInDegrees() {
        XCTAssertEqual(
            BellConstants.rotationInDegress,
            10,
            "La valeur de rotation en degrés devrait être 10"
        )
    }
}

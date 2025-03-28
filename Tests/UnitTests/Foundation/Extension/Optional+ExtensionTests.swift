//
//  Optional+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/01/2024.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import XCTest
@_spi(SI_SPI) @testable import SparkCommon

final class OptionalExtensionTests: XCTestCase {

    // MARK: - String Tests

    func test_nil_string() {
        // GIVEN
        let string: String? = nil

        // WHEN
        let isEmptyOrNil = string.isEmptyOrNil

        // THEN
        XCTAssertTrue(isEmptyOrNil)
    }

    func test_empty_string() {
        // GIVEN
        let string: String? = ""

        // WHEN
        let isEmptyOrNil = string.isEmptyOrNil

        // THEN
        XCTAssertTrue(isEmptyOrNil)
    }

    func test_string() {
        // GIVEN
        let string: String? = "Hello"

        // WHEN
        let isEmptyOrNil = string.isEmptyOrNil

        // THEN
        XCTAssertFalse(isEmptyOrNil)
    }

    // MARK: - Array Tests

    func test_nil_array() {
        // GIVEN
        let array: [Int]? = nil

        // WHEN
        let isEmptyOrNil = array.isEmptyOrNil

        // THEN
        XCTAssertTrue(isEmptyOrNil)
    }

    func test_empty_array() {
        // GIVEN
        let array: [Int]? = []

        // WHEN
        let isEmptyOrNil = array.isEmptyOrNil

        // THEN
        XCTAssertTrue(isEmptyOrNil)
    }

    func test_array() {
        // GIVEN
        let array: [Int]? = [10, 22, 3]

        // WHEN
        let isEmptyOrNil = array.isEmptyOrNil

        // THEN
        XCTAssertFalse(isEmptyOrNil)
    }
}

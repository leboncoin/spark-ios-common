//
//  SnapshotTestCase.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit
import SparkTheme

@_spi(SI_SPI) open class SnapshotTestCase: XCTestCase {

    // MARK: - Set up

    override open class func setUp() {
        super.setUp()

        SparkConfiguration.load()
        SnapshotTestCaseTracker.shared.subscribe()
    }
}

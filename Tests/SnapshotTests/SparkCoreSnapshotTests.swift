//
//  SparkCoreSnapshotTests.swift
//  SparkCoreTests
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
@_implementationOnly import SnapshotTesting
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SwiftUI

// MARK: - UIKit snapshot example
final class SparkCoreUISnapshotTests: UIKitComponentSnapshotTestCase {
    func testExample() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        view.backgroundColor = .red
        sparkAssertSnapshot(matching: view, as: .image)
    }

    func testDynamicContentSize() throws {
        let view = UILabel()
        view.text = "Hello world"
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        assertSnapshotInDarkAndLight(matching: view)
    }
}

// MARK: - SwiftUI snapshot example
final class SparkCoreSnapshotTests: SwiftUIComponentSnapshotTestCase {
    func testDynamicContentSize() throws {
        let view = Text("Hello world").fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }
}

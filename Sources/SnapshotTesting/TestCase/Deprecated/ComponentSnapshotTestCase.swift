//
//  ComponentSnapshotTestCase.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit

// MARK: - Constants

@_spi(SI_SPI) public enum Constants {
    public static let record = false
    public static let timeout: TimeInterval = 5

    static let namedSuffixForLight = "light"
    static let namedSuffixForDark = "dark"

    static let imagePrecision: Float = 0.98
    static let imagePerceptualPrecision: Float = 0.98

    public static let sizes: [UIContentSizeCategory] = [.extraSmall, .medium, .accessibilityExtraExtraExtraLarge]

    static let separator = "-"
}

// MARK: - SwiftUI

@_spi(SI_SPI) public extension SwiftUIComponentSnapshotTestCase {

    // MARK: - Snapshot Testing

    @available(*, deprecated, message: "Use assertSnapshot instead !")
    func assertSnapshotInDarkAndLight(
        matching view: @autoclosure () -> some View,
        named name: String? = nil,
        sizes: [UIContentSizeCategory] = Constants.sizes,
        record recording: Bool = Constants.record,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        // Dark mode testing
        for size in sizes {
            let traits = UITraitCollection(traitsFrom: [.darkMode])
            let filename = [testName, Constants.namedSuffixForDark, size.identifier]
                .joined(separator: Constants.separator)
            sparkAssertSnapshot(
                matching: view().environment(\.sizeCategory, ContentSizeCategory(size) ?? .extraSmall),
                as: .image(precision: Constants.imagePrecision,
                           perceptualPrecision: Constants.imagePerceptualPrecision,
                           traits: traits),
                named: name,
                record: recording,
                timeout: timeout,
                file: file,
                testName: filename,
                line: line
            )
        }

        // Light mode testing
        for size in sizes {
            let filename = [testName, Constants.namedSuffixForLight, size.identifier]
                .joined(separator: Constants.separator)
            sparkAssertSnapshot(
                matching: view().environment(\.sizeCategory, ContentSizeCategory(size) ?? .extraSmall),
                as: .image(precision: Constants.imagePrecision,
                           perceptualPrecision: Constants.imagePerceptualPrecision),
                named: name,
                record: recording,
                timeout: timeout,
                file: file,
                testName: filename,
                line: line
            )
        }
    }
}

// MARK: - UIKit

@_spi(SI_SPI) public extension UIKitComponentSnapshotTestCase {

    // MARK: - Snapshot Testing

    @available(*, deprecated, message: "Use assertSnapshot instead !")
    func assertSnapshotInDarkAndLight(
        matching view: @autoclosure () -> some UIView,
        named name: String? = nil,
        sizes: [UIContentSizeCategory] = Constants.sizes,
        record recording: Bool = Constants.record,
        delay: TimeInterval = 0,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {

        // Dark mode testing
        for size in sizes {
            let traits = UITraitCollection(traitsFrom: [.darkMode, UITraitCollection(preferredContentSizeCategory: size)])
            let filename = [testName, Constants.namedSuffixForDark, size.identifier]
                .joined(separator: Constants.separator)
            sparkAssertSnapshot(
                matching: view(),
                as: .wait(
                    for: delay,
                    on: .image(
                        precision: Constants.imagePrecision,
                        perceptualPrecision: Constants.imagePerceptualPrecision,
                        traits: traits
                    )
                ),
                named: name,
                record: recording,
                timeout: timeout,
                file: file,
                testName: filename,
                line: line
            )
        }

        // Light mode testing
        for size in sizes {
            let traits = UITraitCollection(preferredContentSizeCategory: size)
            let filename = [testName, Constants.namedSuffixForLight, size.identifier]
                .joined(separator: Constants.separator)

            sparkAssertSnapshot(
                matching: view(),
                as: .wait(
                    for: delay,
                    on: .image(
                        precision: Constants.imagePrecision,
                        perceptualPrecision: Constants.imagePerceptualPrecision,
                        traits: traits
                    )
                ),
                named: name,
                record: recording,
                timeout: timeout,
                file: file,
                testName: filename,
                line: line
            )
        }
    }
}

// MARK: - UIContentSizeCategory identifier extension

private extension UIContentSizeCategory {
    /// Returns the identifier used in the filename
    var identifier: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .extraSmall:
            return "extraSmall"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .extraLarge:
            return "extraLarge"
        case .extraExtraLarge:
            return "extraExtraLarge"
        case .extraExtraExtraLarge:
            return "extraExtraExtraLarge"
        case .accessibilityMedium:
            return "accessibilityMedium"
        case .accessibilityLarge:
            return "accessibilityLarge"
        case .accessibilityExtraLarge:
            return "accessibilityExtraLarge"
        case .accessibilityExtraExtraLarge:
            return "accessibilityExtraExtraLarge"
        case .accessibilityExtraExtraExtraLarge:
            return "accessibilityExtraExtraExtraLarge"
        default:
            return "unknown"
        }
    }
}

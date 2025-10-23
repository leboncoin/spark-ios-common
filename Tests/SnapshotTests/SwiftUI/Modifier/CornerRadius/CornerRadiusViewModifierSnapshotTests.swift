//
//  CornerRadiusViewModifierSnapshotTests.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkCommon
@_spi(SI_SPI) @testable import SparkCommonSnapshotTesting
import SparkTheme
import SparkTheming

final class CornerRadiusViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test_default() throws {
        let theme: any Theme = SparkTheme.shared

        for radius in BorderRadius.allCases {
            self.assertSnapshot(
                matching: SnapshotView(
                    state: .default,
                    cornerRadius: radius.value(from: theme)
                ),
                modes: ComponentSnapshotTestConstants.Modes.default,
                sizes: ComponentSnapshotTestConstants.Sizes.default,
                testName: #function + "\(radius)Radius"
            )
        }
    }

    func test_highlighted() throws {
        let theme: any Theme = SparkTheme.shared

        for radius in BorderRadius.allCases {
            self.assertSnapshot(
                matching: SnapshotView(
                    state: .highlighted,
                    cornerRadius: radius.value(from: theme)),
                modes: ComponentSnapshotTestConstants.Modes.default,
                sizes: ComponentSnapshotTestConstants.Sizes.default,
                testName: #function + "\(radius)Radius"
            )
        }
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared
    @ScaledMetric var width: CGFloat = 140
    @ScaledMetric var height: CGFloat = 20

    let state: BorderRadiusState

    let cornerRadius: CGFloat

    // MARK: - Initialization

    init(
        state: BorderRadiusState,
        cornerRadius: CGFloat
    ) {
        self.state = state
        self.cornerRadius = cornerRadius
    }

    // MARK: - View

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(self.state.name)
                .padding(4)
                .frame(width: self.width, height: self.height)
                .background(.white)
                .cornerRadius(
                    state: self.state,
                    cornerRadius: self.cornerRadius
                )

            Rectangle()
                .fill(.white)
                .frame(width: self.width, height: self.height)
                .cornerRadius(
                    state: self.state,
                    cornerRadius: self.cornerRadius
                )
        }
        .padding(20)
        .background(.gray)
    }
}

private extension View {

    @ViewBuilder
    func cornerRadius(
        state: BorderRadiusState,
        cornerRadius: CGFloat
    ) -> some View {
        switch state {
        case .highlighted:
            self.sparkCornerRadius(
                cornerRadius,
                isHighlighted: true,
                isScaled: false
            )

        default:
            self.sparkCornerRadius(
                cornerRadius,
                isScaled: false
            )
        }
    }
}

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

    func test() throws {
        let theme: Theme = SparkTheme.shared

        for radius in SparkBorder.Radius.allCases {
            self.assertSnapshot(
                matching: SnapshotView(cornerRadius: radius.value(from: theme)),
                modes: ComponentSnapshotTestConstants.Modes.default,
                sizes: ComponentSnapshotTestConstants.Sizes.default
            )
        }
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    @ScaledMetric var width: CGFloat = 120
    @ScaledMetric var height: CGFloat = 20

    let cornerRadius: CGFloat

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text("Default")
                    .padding(4)
                    .frame(width: self.width, height: self.height)
                    .background(.white)
                    .sparkCornerRadius(self.cornerRadius)

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .sparkCornerRadius(self.cornerRadius)
            }

            Divider()

            HStack(spacing: 10) {
                Text("Is highlight")
                    .padding(4)
                    .frame(width: self.width, height: self.height)
                    .background(.white)
                    .sparkCornerRadius(
                        self.cornerRadius,
                        isHighlighted: true
                    )

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .sparkCornerRadius(
                        self.cornerRadius,
                        isHighlighted: true
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

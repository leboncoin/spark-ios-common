//
//  ScaledBorderRadiusViewModifierSnapshotTests.swift
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

final class ScaledBorderRadiusViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test() throws {
        let theme: any Theme = SparkTheme.shared

        for radius in SparkBorder.Radius.allCases {
            self.assertSnapshot(
                matching: SnapshotView(borderRadius: radius.value(from: theme)),
                modes: ComponentSnapshotTestConstants.Modes.default,
                sizes: UIContentSizeCategory.snapshotsCases
            )
        }
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared
    @ScaledMetric var width: CGFloat = 90
    @ScaledMetric var height: CGFloat = 20

    let borderWidth: CGFloat
    let borderRadius: CGFloat
    @ScaledMetric var scaledBorderWidth: CGFloat = 0
    @ScaledMetric var scaledBorderRadius: CGFloat = 0

    let borderColor: any ColorToken

    // MARK: - Initialization

    init(borderRadius: CGFloat) {
        self.borderWidth = self.theme.border.width.medium
        self.borderRadius = borderRadius
        self._scaledBorderWidth = .init(wrappedValue: self.borderWidth)
        self._scaledBorderRadius = .init(wrappedValue: self.borderRadius)
        self.borderColor = self.theme.colors.main.main
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text(".sparkBorder(...) ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                HStack {
                    ForEach(RadiusState.allCases, id: \.rawValue) { state in
                        Rectangle()
                            .fill(.white)
                            .frame(width: self.width, height: self.height)
                            .sparkBorder(
                                width: self.borderWidth,
                                radius: self.borderRadius,
                                isHighlighted: state.isHighlighted,
                                colorToken: self.borderColor
                            )
                    }
                }
            }

            Divider()

            HStack(spacing: 10) {
                Text("@ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                HStack {
                    ForEach(RadiusState.allCases, id: \.rawValue) { state in
                        Rectangle()
                            .fill(.white)
                            .frame(width: self.width, height: self.height)
                            .sparkBorder(
                                width: self.scaledBorderWidth,
                                radius: self.scaledBorderRadius,
                                isHighlighted: state.isHighlighted,
                                colorToken: self.borderColor,
                                isScaled: false
                            )
                    }
                }
            }

            Divider()

            HStack(spacing: 10) {
                Text("Without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                HStack {
                    ForEach(RadiusState.allCases, id: \.rawValue) { state in
                        Rectangle()
                            .fill(.white)
                            .frame(width: self.width, height: self.height)
                            .sparkBorder(
                                width: self.borderWidth,
                                radius: self.borderRadius,
                                isHighlighted: state.isHighlighted,
                                colorToken: self.borderColor,
                                isScaled: false
                            )
                    }
                }
            }
        }
        .padding(20)
        .background(.gray)
    }
}

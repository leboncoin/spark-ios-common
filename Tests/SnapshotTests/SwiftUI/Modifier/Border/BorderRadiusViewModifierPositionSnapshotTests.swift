//
//  BorderRadiusViewModifierPositionSnapshotTests.swift
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

final class BorderRadiusViewModifierPositionSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test() throws {
        for width in BorderWidth.allCases {
            let theme: any Theme = SparkTheme.shared
            self.assertSnapshot(
                matching: SnapshotView(borderWidth: width.value(from: theme)),
                modes: ComponentSnapshotTestConstants.Modes.default,
                sizes: ComponentSnapshotTestConstants.Sizes.default,
                testName: #function + "\(width)Width"
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

    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let borderColor: any ColorToken

    // MARK: - Initialization

    init(borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        self.cornerRadius = self.theme.border.radius.large
        self.borderColor = self.theme.colors.main.main
    }

    // MARK: - View

    var body: some View {
        HStack(spacing: 10) {
            ForEach(BorderPosition.allCases, id: \.rawValue) { position in
                Text(position.rawValue.capitalized)
                    .padding(4)
                    .frame(width: self.width, height: self.height)
                    .background(.white)
                    .sparkBorder(
                        width: self.borderWidth,
                        radius: self.cornerRadius,
                        colorToken: self.borderColor,
                        position: position,
                        isScaled: false
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

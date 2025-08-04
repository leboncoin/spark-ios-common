//
//  BorderRadiusViewModifierSnapshotTests.swift
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

final class BorderRadiusViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test() throws {
        self.assertSnapshot(
            matching: SnapshotView(),
            modes: ComponentSnapshotTestConstants.Modes.default,
            sizes: ComponentSnapshotTestConstants.Sizes.default
        )
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared
    @ScaledMetric var width: CGFloat = 140
    @ScaledMetric var height: CGFloat = 30

    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let borderColor: any ColorToken

    // MARK: - Initialization

    init() {
        self.borderWidth = self.theme.border.width.medium
        self.cornerRadius = self.theme.border.radius.medium
        self.borderColor = self.theme.colors.main.main
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text("Default")
                    .padding(4)
                    .frame(width: self.width, height: self.height)
                    .background(.white)
                    .sparkBorder(
                        width: self.borderWidth,
                        radius: self.cornerRadius,
                        colorToken: self.borderColor,
                    )

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .sparkBorder(
                        width: self.borderWidth,
                        radius: self.cornerRadius,
                        colorToken: self.borderColor
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("Is highlight")
                    .padding(4)
                    .frame(width: self.width, height: self.height)
                    .background(.white)
                    .sparkBorder(
                        width: self.borderWidth,
                        radius: self.cornerRadius,
                        isHighlighted: true,
                        colorToken: self.borderColor,
                    )

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .sparkBorder(
                        width: self.borderWidth,
                        radius: self.cornerRadius,
                        isHighlighted: true,
                        colorToken: self.borderColor
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

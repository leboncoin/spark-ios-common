//
//  ScaledBorderViewModifierSnapshotTests.swift
//  SparkCommon
//
//  Created by robin.lemaire on 11/04/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkCommon
@_spi(SI_SPI) @testable import SparkCommonSnapshotTesting
import SparkTheme
import SparkTheming

final class ScaledBorderViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test() throws {
        self.assertSnapshot(
            matching: SnapshotView(),
            modes: [ComponentSnapshotTestMode.light],
            sizes: UIContentSizeCategory.snapshotsCases
        )
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared
    @ScaledMetric var width: CGFloat = 90
    @ScaledMetric var height: CGFloat = 30

    let borderWidth: CGFloat
    let borderRadius: CGFloat
    @ScaledMetric var scaledBorderWidth: CGFloat = 0
    @ScaledMetric var scaledBorderRadius: CGFloat = 0

    let borderColor: any ColorToken

    // MARK: - Initialization

    init() {
        self.borderWidth = self.theme.border.width.medium
        self.borderRadius = self.theme.border.radius.medium
        self._scaledBorderWidth = .init(wrappedValue: self.borderWidth)
        self._scaledBorderRadius = .init(wrappedValue: self.borderRadius)
        self.borderColor = self.theme.colors.main.main
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text(".scaledBorder(...) ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .scaledBorder(
                        width: self.borderWidth,
                        radius: self.borderRadius,
                        colorToken: self.borderColor
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("@ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .border(
                        width: self.scaledBorderWidth,
                        radius: self.scaledBorderRadius,
                        colorToken: self.borderColor
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("Without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .border(
                        width: self.borderWidth,
                        radius: self.borderRadius,
                        colorToken: self.borderColor
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

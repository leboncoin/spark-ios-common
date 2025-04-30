//
//  ScaledFrameRangeViewModifierSnapshotTests.swift
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

final class ScaledFrameRangeViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

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

    let width: CGFloat = 90
    let minWidth: CGFloat = 80
    let maxWidth: CGFloat = 100
    @ScaledMetric var scaledWidth: CGFloat = 90
    @ScaledMetric var scaledMinWidth: CGFloat = 0
    @ScaledMetric var scaledMaxWidth: CGFloat = 0

    let height: CGFloat = 30
    let minHeight: CGFloat = 20
    let maxHeight: CGFloat = 40
    @ScaledMetric var scaledHeight: CGFloat = 0
    @ScaledMetric var scaledMinHeight: CGFloat = 0
    @ScaledMetric var scaledMaxHeight: CGFloat = 0

    // MARK: - Initialization

    init() {
        self._scaledWidth = .init(wrappedValue: self.width)
        self._scaledMinWidth = .init(wrappedValue: self.minWidth)
        self._scaledMaxWidth = .init(wrappedValue: self.maxWidth)
        self._scaledHeight = .init(wrappedValue: self.height)
        self._scaledMinHeight = .init(wrappedValue: self.minHeight)
        self._scaledMaxHeight = .init(wrappedValue: self.maxHeight)
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text(".scaledFrame(...) ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Spacer()

                Rectangle()
                    .fill(.white)
                    .scaledFrame(width: self.width, height: self.height)
                    .scaledFrame(
                        minWidth: self.minWidth,
                        maxWidth: self.maxWidth,
                        minHeight: self.minHeight,
                        maxHeight: self.maxHeight
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("@ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Spacer()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.scaledWidth, height: self.scaledHeight)
                    .frame(
                        minWidth: self.scaledMinWidth,
                        maxWidth: self.scaledMaxWidth,
                        minHeight: self.scaledMinHeight,
                        maxHeight: self.scaledMaxHeight
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("Without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Spacer()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .frame(
                        minWidth: self.minWidth,
                        maxWidth: self.maxWidth,
                        minHeight: self.minHeight,
                        maxHeight: self.maxHeight
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

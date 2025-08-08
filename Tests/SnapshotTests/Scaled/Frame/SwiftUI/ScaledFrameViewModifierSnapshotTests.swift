//
//  ScaledFrameViewModifierSnapshotTests.swift
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

final class ScaledFrameViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

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
    let height: CGFloat = 30

    @ScaledMetric var scaledWidth: CGFloat = 0
    @ScaledMetric var scaledHeight: CGFloat = 0

    // MARK: - Initialization

    init() {
        self._scaledWidth = .init(wrappedValue: self.width)
        self._scaledHeight = .init(wrappedValue: self.height)
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text(".sparkFrame(...) ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .sparkFrame(
                        width: self.width,
                        height: self.height
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("@ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(
                        width: self.scaledWidth,
                        height: self.scaledHeight
                    )
            }

            Divider()

            HStack(spacing: 10) {
                Text("Without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(
                        width: self.width,
                        height: self.height
                    )
            }
        }
        .padding(20)
        .background(.gray)
    }
}

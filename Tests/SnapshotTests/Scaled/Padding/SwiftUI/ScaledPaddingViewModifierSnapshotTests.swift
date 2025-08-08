//
//  ScaledPaddingViewModifierSnapshotTests.swift
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

final class ScaledPaddingViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

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

    let width: CGFloat = 50
    let height: CGFloat = 50

    let padding: CGFloat = 10
    @ScaledMetric var scaledPadding: CGFloat = 0

    // MARK: - Initialization

    init() {
        self._scaledPadding = .init(wrappedValue: self.padding)
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text(".sparkPadding(...) ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .sparkPadding(self.padding)
                    .background(.orange)

            }

            Divider()

            HStack(spacing: 10) {
                Text("@ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .padding(self.scaledPadding)
                    .background(.orange)
            }

            Divider()

            HStack(spacing: 10) {
                Text("Without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                Rectangle()
                    .fill(.white)
                    .frame(width: self.width, height: self.height)
                    .padding(self.padding)
                    .background(.orange)
            }
        }
        .padding(20)
        .background(.gray)
    }
}

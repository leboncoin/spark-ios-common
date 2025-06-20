//
//  ScaledVStackSnapshotTests.swift
//  SparkCommon
//
//  Created by robin.lemaire on 20/06/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkCommon
@_spi(SI_SPI) @testable import SparkCommonSnapshotTesting
import SparkTheme
import SparkTheming

final class ScaledVStackSnapshotTests: SwiftUIComponentSnapshotTestCase {

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

    let width: CGFloat = 25
    let height: CGFloat = 25

    let spacing: CGFloat = 10
    @ScaledMetric var scaledSpacing: CGFloat = 0

    // MARK: - Initialization

    init() {
        self._scaledSpacing = .init(wrappedValue: self.spacing)
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {

            HStack(alignment: .center, spacing: 10) {
                Text("ScaledVStack ✅")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                ScaledVStack(spacing: self.spacing) {
                    self.content()
                }
            }

            Divider()

            HStack(spacing: 10) {
                Text("VStack with @ScaledMetric 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                VStack(spacing: self.scaledSpacing) {
                    self.content()
                }
            }

            Divider()

            HStack(spacing: 10) {
                Text("VStack without scaling 🚫")
                    .dynamicTypeSize(.xSmall)
                    .fixedSize()

                VStack(spacing: self.spacing) {
                    self.content()
                }
            }
        }
        .padding(20)
        .background(.gray)
    }

    @ViewBuilder private func content() -> some View {
        ForEach(0..<3) { _ in
            Rectangle()
                .fill(.white)
                .frame(width: self.width, height: self.height)
        }
    }
}

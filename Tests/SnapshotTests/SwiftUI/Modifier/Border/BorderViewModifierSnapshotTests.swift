//
//  BorderViewModifierSnapshotTests.swift
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

final class BorderViewModifierSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Tests

    func test_default() throws {
        self.assertSnapshot(
            matching: SnapshotView(state: .default),
            modes: ComponentSnapshotTestConstants.Modes.default,
            sizes: ComponentSnapshotTestConstants.Sizes.default
        )
    }

    func test_dashed() throws {
        self.assertSnapshot(
            matching: SnapshotView(state: .dashed),
            modes: ComponentSnapshotTestConstants.Modes.default,
            sizes: ComponentSnapshotTestConstants.Sizes.default
        )
    }
}

// MARK: - View

private struct SnapshotView: View {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared
    @ScaledMetric var width: CGFloat = 140
    @ScaledMetric var height: CGFloat = 20

    let state: BorderRadiusState

    let borderWidth: CGFloat
    let borderColor: any ColorToken

    // MARK: - Initialization

    init(
        state: BorderRadiusState
    ) {
        self.state = state

        self.borderWidth = self.theme.border.width.medium
        self.borderColor = self.theme.colors.main.main
    }

    // MARK: - View

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(self.state.name)
                .padding(4)
                .frame(width: self.width, height: self.height)
                .background(.white)
                .border(
                    state: self.state,
                    width: self.borderWidth,
                    color: self.borderColor
                )

            Rectangle()
                .fill(.white)
                .frame(width: self.width, height: self.height)
                .border(
                    state: self.state,
                    width: self.borderWidth,
                    color: self.borderColor
                )
        }
        .padding(20)
        .background(.gray)
    }
}

private extension View {

    @ViewBuilder
    func border(
        state: BorderRadiusState,
        width: CGFloat,
        color: any ColorToken
    ) -> some View {
        switch state {
        case .dashed:
            self.sparkBorder(
                width: width,
                dash: DashState.dashed.dash,
                colorToken: color,
                isScaled: false
            )

        default:
            self.sparkBorder(
                width: width,
                colorToken: color,
                isScaled: false
            )
        }
    }
}

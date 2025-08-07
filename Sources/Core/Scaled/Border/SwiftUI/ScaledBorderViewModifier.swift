//
//  ScaledBorderViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct ScaledBorderViewModifier: ViewModifier {

    // MARK: - Properties

    @LimitedScaledMetric var width: CGFloat
    let colorToken: any ColorToken

    // MARK: - Initialization

    init(
        width: CGFloat,
        colorToken: any ColorToken
    ) {
        self._width = .init(value: width, type: .width)
        self.colorToken = colorToken
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .modifier(BorderViewModifier(
                width: self.width,
                colorToken: self.colorToken
            ))
    }
}

// MARK: - View Extension

internal extension View {

    /// Applies a **Spark** scaled border to a SwiftUI view.
    /// The border width will increase and decrease
    /// depending on the Dynamic Type BUT
    /// a min and max value is applied to limit the modification.
    ///
    /// - Parameters:
    ///   - width: The thickness of the border.
    ///   - colorToken: The color token to use for the border.
    /// - Returns: A modified view with the applied border.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .scaledBorder(
    ///         width: 2,
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    ///
    /// Example with a corner in a **Shape**.
    /// ```swift
    /// Rectangle()
    ///     .fill(.white)
    ///     .frame(width: 80, height: 30)
    ///     .scaledBorder(
    ///         width: 2,
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    func scaledBorder(
        width: CGFloat,
        colorToken: any ColorToken
    ) -> some View {
        self.modifier(ScaledBorderViewModifier(
            width: width,
            colorToken: colorToken
        ))
    }
}

// MARK: - Private Extension

private extension LimitedScaledMetric {

    // MARK: - Initialization

    init(value: CGFloat?, type: ScaledBorderType) {
        let value = value ?? .zero

        self.init(
            value: value,
            minFactor: type.minValueFactor,
            maxFactor: type.maxValueFactor,
            relativeTo: type.swiftUIRelativeTo
        )
    }
}

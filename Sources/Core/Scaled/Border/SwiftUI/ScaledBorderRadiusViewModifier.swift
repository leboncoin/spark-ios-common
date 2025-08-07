//
//  ScaledBorderRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

private struct ScaledBorderRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    @LimitedScaledMetric var width: CGFloat
    @LimitedScaledMetric var radius: CGFloat
    let isHighlighted: Bool
    let colorToken: any ColorToken

    // MARK: - Initialization

    init(
        width: CGFloat,
        radius: CGFloat,
        isHighlighted: Bool,
        colorToken: any ColorToken
    ) {
        self._width = .init(value: width, type: .width)
        self._radius = .init(value: radius, type: .radius)
        self.isHighlighted = isHighlighted
        self.colorToken = colorToken
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .modifier(BorderRadiusViewModifier(
                width: self.width,
                radius: self.radius,
                isHighlighted: self.isHighlighted,
                colorToken: self.colorToken
            ))
    }
}

// MARK: - Internal View Extension

internal extension View {

    /// Applies a **Spark** scaled border radius to a SwiftUI view.
    /// The border width and the corner radius will increase and decrease
    /// depending on the Dynamic Type BUT
    /// a min and max value is applied to limit the modification.
    ///
    /// - Parameters:
    ///   - width: The thickness of the border.
    ///   - radius: The corner radius of the border.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
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
    ///         radius: 12,
    ///         isHighlighted: true,
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
    ///         radius: 12,
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    @ViewBuilder
    func scaledBorder(
        width: CGFloat,
        radius: CGFloat,
        isHighlighted: Bool = false,
        colorToken: any ColorToken
    ) -> some View {
        if width > 0 {
            self.modifier(ScaledBorderRadiusViewModifier(
                width: width,
                radius: radius,
                isHighlighted: isHighlighted,
                colorToken: colorToken
            ))
        } else {
            self.sparkCornerRadius(
                radius,
                isHighlighted: isHighlighted,
                isScaled: true
            )
        }
    }
}

// MARK: - Public View Extension

public extension View {

    @available(*, deprecated, message: "Use sparkBorder or sparkCornerRadius instead.")
    @ViewBuilder
    func scaledBorder(
        width: CGFloat? = nil,
        radius: CGFloat? = nil,
        isHighlighted: Bool = false,
        colorToken: (any ColorToken)? = nil
    ) -> some View {
        if let width, let radius, radius > 0, let colorToken {
            self.modifier(ScaledBorderRadiusViewModifier(
                width: width,
                radius: radius,
                isHighlighted: isHighlighted,
                colorToken: colorToken
            ))

        } else if let width, let colorToken {
            self.scaledBorder(
                width: width,
                colorToken: colorToken
            )

        } else if let radius {
            self.scaledCornerRadius(
                radius,
                isHighlighted: isHighlighted
            )
        } else {
            self
        }
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

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
    @LimitedScaledMetric var dash: CGFloat

    let isHighlighted: Bool
    let colorToken: any ColorToken
    let position: BorderPosition
    let isScaled: Bool

    // MARK: - Initialization

    init(
        width: CGFloat,
        radius: CGFloat,
        dash: CGFloat? = nil,
        isHighlighted: Bool = false,
        colorToken: any ColorToken,
        position: BorderPosition = .default,
        isScaled: Bool
    ) {
        self._width = .init(value: width, type: .width)
        self._radius = .init(value: radius, type: .radius)
        self._dash = .init(value: dash, type: .dash)
        
        self.isHighlighted = isHighlighted
        self.colorToken = colorToken
        self.position = position
        self.isScaled = isScaled
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .sparkCornerRadius(
                self._radius.value(scaled: self.isScaled),
                isHighlighted: self.isHighlighted,
                isScaled: false
            )
            .overlay {
                HighlightedRectangle(
                    cornerRadius: self._radius.value(scaled: self.isScaled),
                    isHighlighted: self.isHighlighted
                )
                .inset(by: self.position.inset(width: self._width.value(scaled: self.isScaled)))
                .stroke(
                    colorToken: self.colorToken,
                    width: self._width.value(scaled: self.isScaled),
                    dash: self._dash.value(scaled: self.isScaled),
                    position: self.position
                )
            }
    }
}

// MARK: - Public View Extension

public extension View {

    /// Add a **Spark** border with corner radius to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - dash: The length of painted segments used to make a
    ///     dashed line. *Optional*. Default is *nil*.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    ///   - colorToken: The color token of the border.
    ///   - position: The position of the border in the view.
    ///     Default is *overlay*.
    ///   - isScaled: Apply a different width and radius depending on current the
    ///   dynamic size. Default is *true*.
    /// - Returns: Current View.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .sparkBorder(
    ///         width: 2,
    ///         radius: 12,
    ///         dash: 4,
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
    ///     .sparkBorder(
    ///         width: 2,
    ///         radius: 12,
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    @ViewBuilder
    func sparkBorder(
        width: CGFloat,
        radius: CGFloat,
        dash: CGFloat? = nil,
        isHighlighted: Bool = false,
        colorToken: any ColorToken,
        position: BorderPosition = .default,
        isScaled: Bool = true
    ) -> some View {
        if width > 0 {
            self.modifier(ScaledBorderRadiusViewModifier(
                width: width,
                radius: radius,
                dash: dash,
                isHighlighted: isHighlighted,
                colorToken: colorToken,
                position: position,
                isScaled: isScaled
            ))
        } else {
            self.sparkCornerRadius(
                radius,
                isHighlighted: isHighlighted,
                isScaled: isScaled
            )
        }
    }

    @available(*, deprecated, message: "Use sparkBorder instead.")
    func border(
        width: CGFloat,
        radius: CGFloat,
        colorToken: any ColorToken
    ) -> some View {
        self.sparkBorder(
            width: width,
            radius: radius,
            colorToken: colorToken,
            isScaled: false
        )
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

//
//  BorderRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct BorderRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    let width: CGFloat
    let radius: CGFloat
    let dash: CGFloat?
    let isHighlighted: Bool
    let colorToken: any ColorToken

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .sparkCornerRadius(
                self.radius,
                isHighlighted: self.isHighlighted
            )
            .overlay {
                if self.isHighlighted {
                    HighlightedRectangle(
                        cornerRadius: self.radius,
                        isHighlighted: self.isHighlighted
                    )
                    .stroke(
                        colorToken: self.colorToken,
                        width: self.width,
                        dash: self.dash
                    )
                } else {
                    RoundedRectangle(
                        cornerRadius: self.radius
                    )
                    .stroke(
                        colorToken: self.colorToken,
                        width: self.width,
                        dash: self.dash
                    )
                }
            }
    }
}

// MARK: - View Extension

public extension View {

    /// Add a **Spark** border with corner radius to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - dash: The length of painted segments used to make a
    ///     dashed line. *Optional*. Default is *nil*.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    ///   - colorToken: The color token of the border.
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
        isScaled: Bool = true
    ) -> some View {
        if width > 0 {
            if isScaled {
                self.scaledBorder(
                    width: width,
                    radius: radius,
                    dash: dash,
                    isHighlighted: isHighlighted,
                    colorToken: colorToken
                )
            } else {
                self.modifier(BorderRadiusViewModifier(
                    width: width,
                    radius: radius,
                    dash: dash,
                    isHighlighted: isHighlighted,
                    colorToken: colorToken
                ))
            }
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

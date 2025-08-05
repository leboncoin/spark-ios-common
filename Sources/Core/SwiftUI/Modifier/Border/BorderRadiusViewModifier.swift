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
    let isHighlighted: Bool
    let colorToken: any ColorToken

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .sparkCornerRadius(
                self.radius,
                isHighlighted: self.isHighlighted
            )
            .overlay(
                HighlightRectangle(
                    cornerRadius: self.radius,
                    isHighlighted: self.isHighlighted
                )
                .stroke(self.colorToken.color, lineWidth: self.width)
            )
    }
}

// MARK: - Shape

private struct HighlightRectangle: Shape {

    // MARK: - Properties

    let cornerRadius: CGFloat
    let isHighlighted: Bool

    // MARK: - Path

    func path(in rect: CGRect) -> Path {
        let corners: UIRectCorner = self.isHighlighted ? [
            .topLeft,
            .topRight,
            .bottomRight
        ] : .allCorners

        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadius: self.cornerRadius
        )

        return Path(path.cgPath)
    }
}

// MARK: - View Extension

public extension View {

    /// Add a **Spark** border with corner radius to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
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
        isHighlighted: Bool = false,
        colorToken: any ColorToken,
        isScaled: Bool = true
    ) -> some View {
        if width > 0 {
            if isScaled {
                self.scaledBorder(
                    width: width,
                    radius: radius,
                    isHighlighted: isHighlighted,
                    colorToken: colorToken
                )
            } else {
                self.modifier(BorderRadiusViewModifier(
                    width: width,
                    radius: radius,
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

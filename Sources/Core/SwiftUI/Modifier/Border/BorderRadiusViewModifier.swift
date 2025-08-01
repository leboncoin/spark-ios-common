//
//  BorderRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

private struct BorderRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    let width: CGFloat
    let radius: CGFloat
    let isHighlighted: Bool
    let colorToken: any ColorToken

    // MARK: - View

    public func body(content: Content) -> some View {
        content
            .corner(
                radius: self.radius,
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
            cornerRadii: CGSize(
                width: self.cornerRadius,
                height: self.cornerRadius
            )
        )

        return Path(path.cgPath)
    }
}

// MARK: - View Extension

public extension View {

    /// Add a border with corner radius to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    ///   - colorToken: The color token of the border.
    /// - Returns: Current View.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .border(
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
    ///     .border(
    ///         width: 2,
    ///         radius: 12,
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    func border(
        width: CGFloat,
        radius: CGFloat,
        isHighlighted: Bool = false,
        colorToken: any ColorToken
    ) -> some View {
        self.modifier(BorderRadiusViewModifier(
            width: width,
            radius: radius,
            isHighlighted: isHighlighted,
            colorToken: colorToken
        ))
    }
}

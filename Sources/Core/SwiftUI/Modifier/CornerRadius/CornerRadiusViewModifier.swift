//
//  CornerRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct CornerRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    let radius: CGFloat
    let isHighlighted: Bool

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .clipShape(HighlightedRectangle(
                cornerRadius: self.radius,
                isHighlighted: self.isHighlighted
            ))
    }
}

// MARK: - View Extension

public extension View {

    /// Add a **Spark** corner radius to the current view.
    /// - Parameters:
    ///   - radius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left).
    ///   Default is *false*.
    ///   - isScaled: Apply a scaled radius depending on current the
    ///   dynamic size. Default is *true*.
    /// - Returns: Current View.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .sparkCornerRadius(12, isHighlighted: true)
    /// ```
    ///
    /// Example with a corner in a **Shape**.
    /// ```swift
    /// Rectangle()
    ///     .fill(.white)
    ///     .frame(width: 80, height: 30)
    ///     .sparkCornerRadius(12, isScaled: false)
    /// ```
    @ViewBuilder
    func sparkCornerRadius(
        _ radius: CGFloat,
        isHighlighted: Bool = false,
        isScaled: Bool = true
    ) -> some View {
        if radius > 0 {
            if isScaled {
                self.scaledCornerRadius(
                    radius,
                    isHighlighted: isHighlighted
                )
            } else {
                self.modifier(CornerRadiusViewModifier(
                    radius: radius,
                    isHighlighted: isHighlighted
                ))
            }
        } else {
            self
        }
    }
}

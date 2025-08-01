//
//  CornerRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

// TODO: Add spark prefix before all name (UIKit too)

private struct CornerRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    let radius: CGFloat
    let isHighlighted: Bool

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .clipShape(.rect(
                topLeadingRadius: self.radius,
                bottomLeadingRadius: self.isHighlighted ? 0 : self.radius,
                bottomTrailingRadius: self.radius,
                topTrailingRadius: self.radius
            ))
    }
}

// MARK: - View Extension

public extension View {

    /// Add a corner radius to the current view.
    /// - Parameters:
    ///   - radius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    /// - Returns: Current View.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .corner(radius: 12, isHighlighted: true)
    /// ```
    ///
    /// Example with a corner in a **Shape**.
    /// ```swift
    /// Rectangle()
    ///     .fill(.white)
    ///     .frame(width: 80, height: 30)
    ///     .corner(radius: 12)
    /// ```
    func corner(
        radius: CGFloat,
        isHighlighted: Bool = false
    ) -> some View {
        self.modifier(CornerRadiusViewModifier(
            radius: radius,
            isHighlighted: isHighlighted
        ))
    }
}

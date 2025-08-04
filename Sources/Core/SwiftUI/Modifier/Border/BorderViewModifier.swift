//
//  BorderViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct BorderViewModifier: ViewModifier {

    // MARK: - Properties

    let width: CGFloat
    let colorToken: any ColorToken

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .stroke(self.colorToken.color, lineWidth: self.width)
            )
    }
}

// MARK: - View Extension

public extension View {

    /// Add a **Spark** border to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - colorToken: The color token of the border.
    ///   - isScaled: Apply a scaled width depending on current the
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
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    @ViewBuilder
    func sparkBorder(
        width: CGFloat,
        colorToken: any ColorToken,
        isScaled: Bool = true
    ) -> some View {
        if isScaled {
            self.scaledBorder(
                width: width,
                colorToken: colorToken
            )
        } else {
            self.modifier(BorderViewModifier(
                width: width,
                colorToken: colorToken
            ))
        }
    }
}

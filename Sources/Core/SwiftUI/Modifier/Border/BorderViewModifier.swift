//
//  BorderViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

private struct BorderViewModifier: ViewModifier {

    // MARK: - Properties

    let width: CGFloat
    let colorToken: any ColorToken

    // MARK: - View

    public func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .stroke(self.colorToken.color, lineWidth: self.width)
            )
    }
}

// MARK: - View Extension

public extension View {

    /// Add a border to the current view.
    /// - Parameters:
    ///   - width: The border width.
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
    ///         colorToken: YourThemes.shared.colors.main.main
    ///     )
    /// ```
    func border(
        width: CGFloat,
        colorToken: any ColorToken
    ) -> some View {
        self.modifier(BorderViewModifier(
            width: width,
            colorToken: colorToken
        ))
    }
}

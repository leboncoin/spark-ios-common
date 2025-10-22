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
    let dash: CGFloat?
    let colorToken: any ColorToken
    let position: BorderPosition

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .inset(by: self.position.inset(width: self.width))
                    .stroke(
                        colorToken: self.colorToken,
                        width: self.width,
                        dash: self.dash,
                        position: self.position
                    )
            )
    }
}

// MARK: - View Extension

public extension View {

    /// Add a **Spark** border to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - dash: The length of painted segments used to make a
    ///     dashed line. *Optional*. Default is *nil*.
    ///   - colorToken: The color token of the border.
    ///   - position: The position of the border in the view.
    ///     Default is *overlay*.
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
    ///         dash: 4,
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
        dash: CGFloat? = nil,
        colorToken: any ColorToken,
        position: BorderPosition = .default,
        isScaled: Bool = true
    ) -> some View {
        if isScaled {
            self.scaledBorder(
                width: width,
                dash: dash,
                colorToken: colorToken,
                position: position
            )
        } else {
            self.modifier(BorderViewModifier(
                width: width,
                dash: dash,
                colorToken: colorToken,
                position: position
            ))
        }
    }
}

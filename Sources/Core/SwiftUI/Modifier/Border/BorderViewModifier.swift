//
//  BorderViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 31/03/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

@_spi(SI_SPI) public struct BorderViewModifier: ViewModifier {

    // MARK: - Properties

    private let width: CGFloat
    private let radius: CGFloat
    private let colorToken: any ColorToken

    // MARK: - Initialization

    public init(width: CGFloat,
         radius: CGFloat,
         colorToken: any ColorToken) {
        self.width = width
        self.radius = radius
        self.colorToken = colorToken
    }

    // MARK: - View

    public func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .stroke(self.colorToken.color, lineWidth: self.width)
            )
    }
}

// MARK: - View Extension

public extension View {

    /// Add a border to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - colorToken: The color token of the border.
    /// - Returns: Current View.
    func border(width: CGFloat,
                radius: CGFloat,
                colorToken: any ColorToken) -> some View {
        self.modifier(BorderViewModifier(width: width,
                                         radius: radius,
                                         colorToken: colorToken))
    }
}

//
//  View+BorderExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 31/03/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

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

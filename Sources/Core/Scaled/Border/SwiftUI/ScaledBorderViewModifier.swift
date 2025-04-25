//
//  ScaledBorderViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 11/04/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

private struct ScaledBorderViewModifier: ViewModifier {

    // MARK: - Properties

    @LimitedScaledMetric private var width: CGFloat
    @LimitedScaledMetric private var radius: CGFloat
    private let colorToken: (any ColorToken)?

    // MARK: - Initialization

    init(
        width: CGFloat?,
        radius: CGFloat?,
        colorToken: (any ColorToken)?
    ) {
        self._width = .init(value: width, type: .width)
        self._radius = .init(value: radius, type: .radius)
        self.colorToken = colorToken
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .stroke(self.colorToken?.color ?? .clear, lineWidth: self.width)
            )
    }
}

// MARK: - View Extension

public extension View {

     /// Applies a scaled border to a SwiftUI view.
     /// The border width and the corner radius will increase and decrease
     /// depending on the Dynamic Type BUT
     /// a min and max value is applied to limit the modification.
     ///
     /// - Parameters:
     ///   - width: The thickness of the border. If nil, no border will be displayed.
     ///   - radius: The corner radius of the border. If nil, no radius will be displayed.
     ///   - colorToken: The color token to use for the border. If nil, a .clear color will be used.
     /// - Returns: A modified view with the applied border.
     ///
     /// Example usage:
     /// ```swift
     /// Text("Hello World")
     /// .scaledBorder(
    ///     width: 2,
    ///     radius: 8,
    ///     colorToken: YourThemes.shared.colors.main.main
    ///  )
    /// ```
    func scaledBorder(
        width: CGFloat? = nil,
        radius: CGFloat? = nil,
        colorToken: (any ColorToken)? = nil
    ) -> some View {
        self.modifier(ScaledBorderViewModifier(
            width: width,
            radius: radius,
            colorToken: colorToken
        ))
    }
}

// MARK: - Private Extension

private extension LimitedScaledMetric {

    // MARK: - Initialization

    init(value: CGFloat?, type: ScaledBorderType) {
        let value = value ?? .zero

        self.init(
            value: value,
            minFactor: type.minValueFactor,
            maxFactor: type.maxValueFactor,
            relativeTo: type.swiftUIRelativeTo
        )
    }
}

//
//  ScaledCornerRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct ScaledCornerRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    @LimitedScaledMetric var radius: CGFloat
    let isHighlighted: Bool

    // MARK: - Initialization

    init(
        radius: CGFloat,
        isHighlighted: Bool
    ) {
        self._radius = .init(value: radius, type: .radius)
        self.isHighlighted = isHighlighted
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .modifier(CornerRadiusViewModifier(
                radius: self.radius,
                isHighlighted: self.isHighlighted
            ))
    }
}

// MARK: - View Extension

public extension View {

    /// Applies a **Spark** scaled corner radius to a SwiftUI view.
    /// The corner radius will increase and decrease
    /// depending on the Dynamic Type BUT
    /// a min and max value is applied to limit the modification.
    ///
    /// - Parameters:
    ///   - radius: The corner radius of the border.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    /// - Returns: A modified view with the applied border.
    ///
    /// Example with a corner in a **Text**.
    /// ```swift
    /// Text("Text")
    ///     .padding(4)
    ///     .frame(width: 80, height: 30)
    ///     .background(.white)
    ///     .scaledCornerRadius(12, isHighlighted: true)
    /// ```
    ///
    /// Example with a corner in a **Shape**.
    /// ```swift
    /// Rectangle()
    ///     .fill(.white)
    ///     .frame(width: 80, height: 30)
    ///     .scaledCornerRadius(12)
    /// ```
    @ViewBuilder
    func scaledCornerRadius(
        _ radius: CGFloat,
        isHighlighted: Bool = false
    ) -> some View {
        if radius > 0 {
            self.modifier(ScaledCornerRadiusViewModifier(
                radius: radius,
                isHighlighted: isHighlighted
            ))
        } else {
            self
        }
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

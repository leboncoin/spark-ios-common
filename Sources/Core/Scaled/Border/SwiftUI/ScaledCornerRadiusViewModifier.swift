//
//  ScaledCornerRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

private struct ScaledCornerRadiusViewModifier: ViewModifier {

    // MARK: - Properties

    @LimitedScaledMetric var radius: CGFloat

    let isHighlighted: Bool
    let isScaled: Bool

    // MARK: - Initialization

    init(
        radius: CGFloat,
        isHighlighted: Bool,
        isScaled: Bool
    ) {
        self._radius = .init(value: radius, type: .radius)
        
        self.isHighlighted = isHighlighted
        self.isScaled = isScaled
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            // .clipShape(UnevenRoundedRectangle(topLeadingRadius: <#T##CGFloat#>, bottomLeadingRadius: <#T##CGFloat#>, bottomTrailingRadius: <#T##CGFloat#>, topTrailingRadius: <#T##CGFloat#>, style: <#T##RoundedCornerStyle#>))
            .clipShape(HighlightedRectangle(
                cornerRadius: self._radius.value(scaled: self.isScaled),
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
            self.modifier(ScaledCornerRadiusViewModifier(
                radius: radius,
                isHighlighted: isHighlighted,
                isScaled: isScaled
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

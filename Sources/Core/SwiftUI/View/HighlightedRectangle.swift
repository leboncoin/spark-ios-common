//
//  BorderRadiusViewModifier.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal struct HighlightedRectangle: Shape {

    // MARK: - Properties

    let cornerRadius: CGFloat
    let isHighlighted: Bool

    // MARK: - Path

    func path(in rect: CGRect) -> Path {
        let corners: UIRectCorner = self.isHighlighted ? [
            .topLeft,
            .topRight,
            .bottomRight
        ] : .allCorners

        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadius: self.cornerRadius
        )

        return Path(path.cgPath)
    }
}

//
//  SparkBorder+RadiusExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 04/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming
import SparkTheme

extension SparkBorder {

    // MARK: - Radius

    enum Radius: String, CaseIterable {
        case small
        case medium
        case xLarge
        case full

        // MARK: - Methods

        func value(from theme: any Theme) -> CGFloat {
            let radius = theme.border.radius

            return switch self {
            case .small: radius.small
            case .medium: radius.medium
            case .xLarge: radius.xLarge
            case .full: radius.full
            }
        }
    }
}

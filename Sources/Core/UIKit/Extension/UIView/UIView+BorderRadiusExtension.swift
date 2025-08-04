//
//  UIView+BorderRadiusExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import UIKit
import SparkTheming

public extension UIView {

    private enum Constants {
        static let name = "SparkBorderRadius"
    }

    /// Add a **Spark** border with corner radius to the current view.
    ///
    /// Note: Recommanded to set on *layoutSubviews* to avoid any issue on cornerRadius.
    ///
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    ///   - colorToken: The color token of the border.
    func sparkBorderRadius(
        width: CGFloat,
        radius: CGFloat,
        isHighlighted: Bool = false,
        colorToken: any ColorToken
    ) {
        // Remove previous spark sublayers
        self.layer.sublayers?.removeAll(where: { $0.name == Constants.name })

        if isHighlighted {
            // Apply the corner radius
            let mask = self.cornerRadiusMask(radius)

            // Add border
            let borderLayer = CAShapeLayer()
            borderLayer.name = Constants.name
            borderLayer.path = mask.path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = colorToken.uiColor.cgColor
            borderLayer.lineWidth = width * 2
            borderLayer.frame = self.bounds
            self.layer.addSublayer(borderLayer)

            self.layer.cornerRadius = 0
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.mask = mask

        } else {
            self.layer.mask = nil
            self.layer.cornerRadius = radius
            self.layer.borderWidth = width
            self.layer.borderColor = colorToken.uiColor.cgColor
        }

        self.clipsToBounds = true
    }
}

//
//  UIView+RadiusExtension.swift
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
        // No Width ? Add a corner radius instead !
        guard width > 0 else {
            self.sparkCornerRadius(radius, isHighlighted: isHighlighted)
            return
        }

        if #available(iOS 17.0, *) {
            self.updateTraitsIfNeeded()
        }

        self.clear(isHighlighted: isHighlighted)

        let radius = self.validatedCornerRadius(radius)
        let borderColor = colorToken.uiColor.resolvedColor(with: self.traitCollection).cgColor

        if isHighlighted {
            // Apply the corner radius
            let mask = self.cornerRadiusMask(radius)

            // Add border
            let borderLayer = CAShapeLayer()
            borderLayer.name = Constants.name
            borderLayer.path = mask.path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderColor
            borderLayer.lineWidth = width * 2
            borderLayer.frame = self.bounds
            self.layer.addSublayer(borderLayer)

            self.layer.mask = mask
            self.layer.masksToBounds = true

        } else {
            self.layer.cornerRadius = radius
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor
        }
    }

    /// Add a **Spark** corner radius to the current view.
    ///
    /// Note: Recommanded to set on *layoutSubviews* to avoid any issue on cornerRadius.
    ///
    /// - Parameters:
    ///   - cornerRadius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    func sparkCornerRadius(
        _ cornerRadius: CGFloat,
        isHighlighted: Bool = false
    ) {
        self.clear(isHighlighted: isHighlighted)

        let cornerRadius = self.validatedCornerRadius(cornerRadius)

        if isHighlighted {
            let mask = self.cornerRadiusMask(cornerRadius)
            self.layer.mask = mask
            self.layer.masksToBounds = true
        } else {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

// MARK: - Private Extension

private extension UIView {

    func validatedCornerRadius(_ cornerRadius: CGFloat) -> CGFloat {
        return cornerRadius.isInfinite ? self.frame.height / 2 : cornerRadius
    }

    func cornerRadiusMask(
        _ cornerRadius: CGFloat
    ) -> CAShapeLayer {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [
                .topLeft,
                .topRight,
                .bottomRight
            ],
            cornerRadius: cornerRadius
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        return mask
    }

    func clear(isHighlighted: Bool) {
        // Remove previous spark sublayers
        self.layer.sublayers?.removeAll(where: { $0.name == Constants.name })

        if isHighlighted {
            self.layer.cornerRadius = 0
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor

        } else {
            self.layer.mask = nil
        }
    }
}

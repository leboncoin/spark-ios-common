//
//  UIView+CornerRadiusExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import UIKit
import SparkTheming

public extension UIView {

    /// The spark radius to use when drawing rounded corners for the layer’s background. Animatable.
    ///
    /// Note: Must be set on *layoutSubviews* to avoid any issue on cornerRadius.
    ///
    /// - Parameters:
    ///   - cornerRadius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    func sparkCornerRadius(_ cornerRadius: CGFloat, isHighlighted: Bool = false) {
        if isHighlighted {
            let path = UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: [
                    .topLeft,
                    .topRight,
                    .bottomRight
                ],
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            )

            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask

        } else {
            self.layer.cornerRadius = cornerRadius.isInfinite ? self.frame.height / 2 : cornerRadius
        }
    }
}

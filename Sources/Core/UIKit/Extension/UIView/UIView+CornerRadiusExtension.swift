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
        if isHighlighted {
            let mask = self.cornerRadiusMask(cornerRadius)
            self.layer.cornerRadius = 0
            self.layer.mask = mask

        } else {
            self.layer.mask = nil
            self.layer.cornerRadius = cornerRadius
        }

        self.clipsToBounds = true
    }
}

//
//  UIView+CornerRadiusMaskExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import UIKit
import SparkTheming

internal extension UIView {

    // Create a mast to add a corner radius on all corner excepted bottom left.
    // Used by the BorderRadius & CornerRadius
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
}

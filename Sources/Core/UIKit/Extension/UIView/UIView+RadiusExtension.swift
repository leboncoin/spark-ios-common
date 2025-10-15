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
    /// Note: Recommanded to set on *layoutSubviews*  or **viewDidLayoutSubviews** to avoid any issue on cornerRadius.
    /// If the bounds is equals to 0, the isHighlighted parameter will be ignored.
    ///
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - isHighlighted: Apply a custom style (no radius on bottom left). Default is *false*.
    ///   - colorToken: The color token of the border.
    ///   - masksToBounds: A Boolean indicating whether sublayers are clipped to the layer’s bounds. Default is **true**.
    ///   Be carefull if you set the value at **false**, the UI can be impacted.
    func sparkBorderRadius(
        width: CGFloat,
        radius: CGFloat,
        isHighlighted: Bool = false,
        colorToken: any ColorToken,
        masksToBounds: Bool = true
    ) {
        // No Width ? Add a corner radius instead !
        guard width > 0 else {
            self.sparkCornerRadius(radius, isHighlighted: isHighlighted)
            return
        }

        if #available(iOS 17.0, *) {
            self.updateTraitsIfNeeded()
        }

        self.clear()

        let radius = self.validatedCornerRadius(radius)
        let borderColor = colorToken.uiColor.resolvedColor(with: self.traitCollection).cgColor

        // Apply isHighlighted only if bounds is not empty
        if isHighlighted && !self.bounds.isEmpty {

            // Apply the corner radius
            let mask = self.highlightedCornerRadiusMask(radius)

            // Add border
            let borderLayer = self.borderLayer(
                width: width,
                strokeColor: borderColor
            )
            borderLayer.lineWidth = width * 2
            borderLayer.path = mask.path
            self.layer.addSublayer(borderLayer)

            self.layer.mask = mask

        } else {
            self.layer.cornerRadius = radius
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor
        }

        self.layer.masksToBounds = masksToBounds
    }

    /// Add a **Spark** dash border with corner radius to the current view.
    ///
    /// Note: Recommanded to set on *layoutSubviews*  or **viewDidLayoutSubviews** to avoid any issue on cornerRadius.
    /// If the dash is equals to 0, the dash parameter will be ignored.
    ///
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - dash: The length of painted segments used to make a dashed line.
    ///   - colorToken: The color token of the border.
    ///   - masksToBounds: A Boolean indicating whether sublayers are clipped to the layer’s bounds. Default is **true**.
    ///   Be carefull if you set the value at **false**, the UI can be impacted.
    func sparkBorderRadius(
        width: CGFloat,
        radius: CGFloat,
        dash: CGFloat,
        colorToken: any ColorToken,
        masksToBounds: Bool = true
    ) {
        // No Width ? Add a corner radius instead !
        guard width > 0 else {
            self.sparkCornerRadius(radius)
            return
        }

        if #available(iOS 17.0, *) {
            self.updateTraitsIfNeeded()
        }

        self.clear()

        let radius = self.validatedCornerRadius(radius)
        let borderColor = colorToken.uiColor.resolvedColor(with: self.traitCollection).cgColor

        // Apply dash only if bounds is not empty
        if dash > 0 && !self.bounds.isEmpty {

            let bezierPath = self.cornerRadiusBezierPath(
                radius,
                isHighlighted: false
            )

            let borderLayer = self.borderLayer(
                width: width,
                strokeColor: borderColor
            )
            borderLayer.lineWidth = width
            borderLayer.lineDashPattern = dash.toDashArray.map { NSNumber(value: $0) }
            borderLayer.path = bezierPath.cgPath
            self.layer.addSublayer(borderLayer)

        } else {
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor
        }

        // Apply a corner radius in both cases
        self.layer.cornerRadius = radius

        self.layer.masksToBounds = masksToBounds
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
        self.clear()

        let cornerRadius = self.validatedCornerRadius(cornerRadius)

        if isHighlighted {
            let mask = self.highlightedCornerRadiusMask(cornerRadius)
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

    func highlightedCornerRadiusMask(
        _ cornerRadius: CGFloat
    ) -> CAShapeLayer {
        let path = self.cornerRadiusBezierPath(
            cornerRadius,
            isHighlighted: true
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        return mask
    }

    func cornerRadiusBezierPath(
        _ cornerRadius: CGFloat,
        isHighlighted: Bool
    ) -> UIBezierPath {
        return if isHighlighted {
            .init(
                roundedRect: self.bounds,
                byRoundingCorners: [
                    .topLeft,
                    .topRight,
                    .bottomRight
                ],
                cornerRadius: cornerRadius
            )
        } else {
            .init(
                roundedRect: self.bounds,
                cornerRadius: cornerRadius
            )
        }
    }

    func borderLayer(
        width: CGFloat,
        strokeColor: CGColor
    ) -> CAShapeLayer {
        let borderLayer = CAShapeLayer()
        borderLayer.name = Constants.name
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = strokeColor
        borderLayer.frame = self.bounds
        return borderLayer
    }

    func clear() {
        // Remove previous spark sublayers
        if var sublayers = self.layer.sublayers {
            for layer in sublayers.filter({ $0.name == Constants.name}) {
                layer.removeFromSuperlayer()
            }

            sublayers.removeAll(where: { $0.name == Constants.name })
        }

        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor

        // Used for isHighlighted
        self.layer.mask = nil
    }
}

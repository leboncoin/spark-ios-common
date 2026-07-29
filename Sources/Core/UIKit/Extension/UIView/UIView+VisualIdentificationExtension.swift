//
//  UIView+VisualIdentificationExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 29/07/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import UIKit

@_spi(SI_SPI) public extension UIView {

    // MARK: - Constants

    private enum Constants {
        static let identifier = "sparkVisualIdentification"
    }

    // MARK: - Methods

    /// Apply a background on the current view.
    /// Used to differentiate a Spark component (with the background)
    /// and a custom view (without the background).
    /// - Parameter featureTogglesService: The feature toggles service. Defaults to the shared instance.
    func sparkVisualIdentification(
        featureTogglesService: any SparkFeatureToggleServicing = SparkFeatureToggleService.shared
    ) {
        let identificationView = self.subviews.first(where: { $0.accessibilityIdentifier == Constants.identifier })

        guard featureTogglesService.visualIdentification else {
            identificationView?.removeFromSuperview()
            return
        }

        // View Already exists ?
        if let identificationView {
            self.sendSubviewToBack(identificationView)

        } else {
            // Create the view
            let backgroundView = UIView()
            backgroundView.accessibilityIdentifier = Constants.identifier
            backgroundView.backgroundColor = UIColor.green.withAlphaComponent(0.8)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.isUserInteractionEnabled = false

            self.insertSubview(backgroundView, at: 0)

            NSLayoutConstraint.stickEdges(from: backgroundView, to: self)
        }
    }
}

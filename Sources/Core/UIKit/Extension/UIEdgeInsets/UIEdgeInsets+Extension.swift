//
//  UIEdgeInsets+Extension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import UIKit

@_spi(SI_SPI) public extension UIEdgeInsets {

    // MARK: - Init

    /// Init UIEdgeInsets with same value for top, left, bottom and right
    /// - Parameters:
    ///   - all: inset value
    init(all value: CGFloat) {
        self = .init(top: value, left: value, bottom: value, right: value)
    }

    /// Init UIEdgeInsets with vertical (use to set top and bottom insets) and horizontal value (use to set left and right insets)
    /// - Parameters:
    ///   - vertical: horizontal inset value use to set left and right insets.
    ///   - horizontal: horizontal inset value use to set left and right insets.
    init(vertical: CGFloat, horizontal: CGFloat) {
        self = .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

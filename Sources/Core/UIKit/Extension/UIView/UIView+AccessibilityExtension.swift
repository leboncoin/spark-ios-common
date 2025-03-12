//
//  UIView+AccessibilityExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 23/01/2024.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import UIKit

@_spi(SI_SPI) public extension UIView {

    /// Insert or remove the trait on the current accessibilityTraits
    func accessibilityTraits(manage trait: UIAccessibilityTraits, insert: Bool) {
        if insert {
            self.accessibilityTraits.insert(trait)
        } else {
            self.accessibilityTraits.remove(trait)
        }
    }
}

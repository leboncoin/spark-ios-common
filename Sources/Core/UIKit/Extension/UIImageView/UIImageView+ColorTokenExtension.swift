//
//  UIImageView+ColorTokenExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 30/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import UIKit
import SparkTheming

public extension UIImageView {

    /// Set a **tintColor** color on UIImageView from a Spark **ColorToken**.
    /// - Parameters:
    ///   - token: the color token.
    func tintColor(_ token: any ColorToken) {
        self.tintColor = token.uiColor
    }
}

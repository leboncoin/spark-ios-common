//
//  CGSize+TraitCollection.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 25.04.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import UIKit

@_spi(SI_SPI) public extension CGSize {
    func scaled(for traitCollection: UITraitCollection) -> CGSize {
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)

        let scaledWidth = bodyFontMetrics.scaledValue(for: width, compatibleWith: traitCollection)
        let scaledHeight = bodyFontMetrics.scaledValue(for: height, compatibleWith: traitCollection)
        return CGSize(width: scaledWidth, height: scaledHeight)
    }
}

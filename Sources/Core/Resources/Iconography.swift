//
//  Iconography.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 29/09/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import UIKit

@_spi(SI_SPI) public extension Image {
    static let sparkCheck = Image("check", bundle: .current)
    static let sparkCross = Image("cross", bundle: .current)
    static let sparkMinus = Image("minus", bundle: .current)
    static let sparkPlus = Image("plus", bundle: .current)
    static let sparkStarFill = Image("starFill", bundle: .current)
    static let sparkStarOutline = Image("starOutline", bundle: .current)
}

@_spi(SI_SPI) public extension UIImage {
    static let sparkCheck = UIImage(named: "check", in: .current, with: nil) ?? UIImage()
    static let sparkCross = UIImage(named: "cross", in: .current, with: nil) ?? UIImage()
    static let sparkMinus = UIImage(named: "minus", in: .current, with: nil) ?? UIImage()
    static let sparkPlus = UIImage(named: "plus", in: .current, with: nil) ?? UIImage()
    static let sparkStarFill = UIImage(named: "starFill", in: .current, with: nil) ?? UIImage()
    static let sparkStarOutline = UIImage(named: "starOutline", in: .current, with: nil) ?? UIImage()
}

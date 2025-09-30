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
    static var sparkCheck: Self = .init(.check)
    static var sparkCross: Self = .init(.cross)
    static var sparkMinus: Self = .init(.minus)
    static var sparkPlus: Self = .init(.plus)
}

@_spi(SI_SPI) public extension UIImage {
    static var sparkCheck: UIImage = .init(resource: .check)
    static var sparkCross: UIImage = .init(resource: .cross)
    static var sparkMinus: UIImage = .init(resource: .minus)
    static var sparkPlus: UIImage = .init(resource: .plus)
}

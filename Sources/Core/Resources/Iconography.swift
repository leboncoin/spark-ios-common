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
    static let sparkAddImageOutline = Image("addImageOutline", bundle: .current)
    static let sparkCheck = Image("check", bundle: .current)
    static let sparkCross = Image("cross", bundle: .current)
    static let sparkExport = Image("export", bundle: .current)
    static let sparkFileOutline = Image("fileOutline", bundle: .current)
    static let sparkImageOutline = Image("imageOutline", bundle: .current)
    static let sparkMinus = Image("minus", bundle: .current)
    static let sparkPdfOutline = Image("pdfOutline", bundle: .current)
    static let sparkPlayOutline = Image("playOutline", bundle: .current)
    static let sparkPlus = Image("plus", bundle: .current)
    static let sparkStarFill = Image("starFill", bundle: .current)
    static let sparkStarOutline = Image("starOutline", bundle: .current)
    static let sparkWarningOutline = Image("warningOutline", bundle: .current)
}

@_spi(SI_SPI) public extension UIImage {
    static let sparkAddImageOutline = UIImage(named: "addImageOutline", in: .current, with: nil) ?? UIImage()
    static let sparkCheck = UIImage(named: "check", in: .current, with: nil) ?? UIImage()
    static let sparkCross = UIImage(named: "cross", in: .current, with: nil) ?? UIImage()
    static let sparkExport = UIImage(named: "export", in: .current, with: nil) ?? UIImage()
    static let sparkFileOutline = UIImage(named: "fileOutline", in: .current, with: nil) ?? UIImage()
    static let sparkImageOutline = UIImage(named: "imageOutline", in: .current, with: nil) ?? UIImage()
    static let sparkMinus = UIImage(named: "minus", in: .current, with: nil) ?? UIImage()
    static let sparkPdfOutline = UIImage(named: "pdfOutline", in: .current, with: nil) ?? UIImage()
    static let sparkPlayOutline = UIImage(named: "playOutline", in: .current, with: nil) ?? UIImage()
    static let sparkPlus = UIImage(named: "plus", in: .current, with: nil) ?? UIImage()
    static let sparkStarFill = UIImage(named: "starFill", in: .current, with: nil) ?? UIImage()
    static let sparkStarOutline = UIImage(named: "starOutline", in: .current, with: nil) ?? UIImage()
    static let sparkWarningOutline = UIImage(named: "warningOutline", in: .current, with: nil) ?? UIImage()
}

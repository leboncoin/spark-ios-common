//
//  ScaledBorderType.swift
//  SparkCommon
//
//  Created by robin.lemaire on 11/04/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import UIKit

internal enum ScaledBorderType {
    case dash
    case radius
    case width

    // MARK: - Properties

    var uiKitRelativeTo: UIFont.TextStyle {
        switch self {
        case .radius: .body
        case .dash, .width: .caption2
        }
    }

    var swiftUIRelativeTo: Font.TextStyle? {
        switch self {
        case .radius: nil
        case .dash, .width: .caption2
        }
    }

    var minValueFactor: CGFloat {
        switch self {
        case .dash, .width: 1
        case .radius: 1
        }
    }

    var maxValueFactor: CGFloat {
        switch self {
        case .dash, .width: 1.75
        case .radius: 1.2
        }
    }
}

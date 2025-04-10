//
//  DisplayedTextType.swift
//  SparkCommon
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

/// Enum used for components which have a text/attributed management.
@_spi(SI_SPI) @frozen public enum DisplayedTextType: CaseIterable {
    /// No text/attributed text is displayed on label
    case none
    /// Text is displayed on label
    case text
    /// Attributed text is displayed on label
    case attributedText

    // MARK: - Properties

    public var containsText: Bool {
        switch self {
        case .none:
            return false
        case .text, .attributedText:
            return true
        }
    }
}

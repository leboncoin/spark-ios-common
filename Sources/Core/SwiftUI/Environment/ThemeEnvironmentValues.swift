//
//  ThemeEnvironmentValues.swift
//  SparkCommon
//
//  Created by robin.lemaire on 10/10/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SparkTheming
@_spi(SI_SPI) import SparkFakeTheme
import SwiftUI

public extension EnvironmentValues {
    @Entry var theme: ThemeDefault = RainbowTheme.shared
}

public extension View {

    /// Set the **theme** (only work if the Theme is init with the ```ThemeDefault```).
    ///
    /// Each components which using ```@Environment(\.theme) private var theme``` will be automatically updated.
    ///
    /// The default value is *RainbowTheme.shared*.
    @ViewBuilder
    func sparkTheme(_ theme: any Theme) -> some View {
        if let theme = theme as? ThemeDefault {
            self.environment(\.theme, theme)
        } else {
            self
        }
    }
}

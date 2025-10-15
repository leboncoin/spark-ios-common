//
//  Shape+PropertiesExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 26/09/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

internal extension Shape {

    @ViewBuilder
    func stroke(colorToken: any ColorToken, width: CGFloat, dash: CGFloat?) -> some View {
        if let dash {
            self.stroke(
                colorToken.color,
                style: StrokeStyle(
                    lineWidth: width,
                    dash: dash.toDashArray
                )
            )
        } else {
            self.stroke(
                colorToken.color,
                lineWidth: width
            )
        }
    }
}

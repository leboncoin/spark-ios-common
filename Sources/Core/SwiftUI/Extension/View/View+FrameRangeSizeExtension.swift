//
//  View+FrameRangeSizeExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 22/10/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI

public extension View {

    /// Applies a  frame to a view with minimum and maximum size constraints.
    ///
    /// - Parameters:
    ///   - minSize: Optional minimum width and height of the frame.
    ///   - maxSize: Optional maximum width and height of the frame.
    ///   - alignment: Alignment of the content within the frame (default: .center).
    /// - Returns: A modified view with the resizable frame applied.
    ///
    /// Example usage:
    /// ```swift
    /// Text("Hello World")
    /// .scaledFrame(
    ///     minSize: 10,
    ///     maxSize: 20
    /// )
    /// ```
    func frame(
        minSize: CGFloat? = nil,
        maxSize: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            minWidth: minSize,
            maxWidth: maxSize,
            minHeight: minSize,
            maxHeight: maxSize,
            alignment: alignment
        )
    }
}

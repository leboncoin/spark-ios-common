//
//  View+OptionalAnimationExtension.swift
//  SparkCommon
//
//  Created by robin.lemaire on 03/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI

public extension View {

    /// Applies the given animation to this view when the specified value
    /// changes IF the **isReduceMotionEnabled** is disabled.
    ///
    /// - Parameters:
    ///   - animation: The animation to apply. If `animation` is `nil`, the view
    ///     doesn't animate.
    ///   - value: A value to monitor for changes.
    ///
    /// - Returns: A view that applies `animation` to this view whenever `value`
    ///   changes.
    @ViewBuilder
    func optionalAnimation<V>(_ animation: Animation?, value: V) -> some View where V: Equatable {
        if UIAccessibility.isReduceMotionEnabled {
            self
        } else {
            self.animation(animation, value: value)
        }
    }

    /// Applies the given animation to all animatable values within the `body`
    /// closure IF the **isReduceMotionEnabled** is disabled.
    ///
    /// Any modifiers applied to the content of `body` will be applied to this
    /// view, and the `animation` will only be used on the modifiers defined in
    /// the `body`.
    ///
    /// The following code animates the opacity changing with an easeInOut
    /// animation, while the contents of MyView are animated with the implicit
    /// transaction's animation:
    ///
    /// ```swift
    /// MyView(isActive: isActive)
    ///     .animation(.easeInOut) { content in
    ///         content.opacity(isActive ? 1.0 : 0.0)
    ///     }
    /// ```
    @available(iOS 17.0, *)
    @ViewBuilder
    func optionalAnimation<V>(_ animation: Animation?, @ViewBuilder body: (PlaceholderContentView<Self>) -> V) -> some View where V: View {
        if UIAccessibility.isReduceMotionEnabled {
            self
        } else {
            self.animation(animation, body: body)
        }
    }
}

/// Returns the result of recomputing the view's body with the provided
/// animation.
///
/// This function sets the given ``Animation`` as the ``Transaction/animation``
/// property of the thread's current ``Transaction``.
public func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

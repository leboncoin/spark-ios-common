//
//  View+SensoryFeedbackExtension.swift
//  SparkComponentChip
//
//  Created by jonathan.gaffe on 29/09/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI

public struct SparkSensoryFeedback: Equatable, Sendable {

    // MARK: - Static

    public static let impact = SparkSensoryFeedback()
    public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium, intensity: Double? = 1.0) -> SparkSensoryFeedback {
        return .init(style: style, intensity: intensity)
    }
    public static let selection = SparkSensoryFeedback()

    // MARK: - Properties

    private let id = UUID()
    fileprivate let style: UIImpactFeedbackGenerator.FeedbackStyle?
    fileprivate let intensity: Double?

    // MARK: - Initialization

    private init(
        style: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
        intensity: Double? = nil
    ) {
        self.style = style
        self.intensity = intensity
    }

    // MARK: - Methods

    @available(iOS 17.0, *)
    fileprivate func feedback() -> SensoryFeedback? {
        switch self {
        case .selection: .selection
        case .impact: .impact
        default: nil
        }
    }
}

// MARK: - FeedbackStyle Extension

@available(iOS 17.0, *)
private extension UIImpactFeedbackGenerator.FeedbackStyle {

    var sensoryImpactParameters: (weight: SensoryFeedback.Weight, intensity: Double) {
        return switch self {
        case .light: (.light, 1.0)
        case .medium: (.medium, 1.0)
        case .heavy: (.heavy, 1.0)
        case .soft: (.light, 0.6)
        case .rigid: (.heavy, 1.0)
        default: (.medium, 1.0)
        }
    }
}

// MARK: - View Extension

public extension View {

    /// Attaches haptic feedback to any `Equatable` trigger with a simple, effect-agnostic API.
    ///
    /// - Parameters:
    ///  - effect: The ``SparkSensoryFeedback``haptic effect to emit. Default is **.impact**.
    ///  - trigger: Any `Equatable` value; a change (by `==`) fires the haptic once.
    @ViewBuilder
    func sparkSensoryFeedback(
        _ effect: SparkSensoryFeedback = .impact,
        trigger: some Equatable
    ) -> some View {
        if #available(iOS 17.0, *) {
            if let feedback = effect.feedback() {
                self.sensoryFeedback(feedback, trigger: trigger)
            } else if let sensoryParameters = effect.style?.sensoryImpactParameters {
                self.sensoryFeedback(
                    .impact(
                        weight: sensoryParameters.weight,
                        intensity: effect.intensity ?? sensoryParameters.intensity
                    ),
                    trigger: trigger
                )
            } else {
                self.sensoryFeedback(.impact, trigger: trigger)
            }
        } else {
            switch effect {
            case .impact:
                self.onChange(of: trigger) { _ in
                    UIImpactFeedbackGenerator().impactOccurred()
                }
            case .selection:
                self.onChange(of: trigger) { _ in
                    UISelectionFeedbackGenerator().selectionChanged()
                }

            default:
                self.onChange(of: trigger) { _ in
                    UIImpactFeedbackGenerator(style: effect.style ?? .medium).impactOccurred()
                }
            }
        }
    }
}

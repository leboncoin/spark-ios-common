//
//  SparkFeatureToggleService.swift
//  SparkCommon
//
//  Created by robin.lemaire on 07/05/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

/// Protocol defining the interface for feature toggle service.
// sourcery: AutoMockable
public protocol SparkFeatureToggleServicing {
    /// Indicates whether the rebranding feature is enabled.
    var rebranding: Bool { get set }
}

/// Service managing feature toggles for the Spark design system.
public struct SparkFeatureToggleService: SparkFeatureToggleServicing {

    // MARK: - Static Properties

    /// Shared instance of the feature toggle service. Can be replaced for testing purposes.
    public static var shared: any SparkFeatureToggleServicing = SparkFeatureToggleService()

    // MARK: - Properties

    /// Indicates whether the rebranding feature is enabled. Default is `false`.
    public var rebranding: Bool = false

    // MARK: - Initialization

    private init() {
    }

    // MARK: - Static Func

    /// Resets the shared instance to its default state with all feature toggles disabled.
    /// - Note: This method is intended for testing purposes only.
    @_spi(SI_SPI) public static func reset() {
        self.shared = SparkFeatureToggleService()
    }
}

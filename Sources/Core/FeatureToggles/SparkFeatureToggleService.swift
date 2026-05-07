//
//  SparkFeatureToggleService.swift
//  SparkCommon
//
//  Created by robin.lemaire on 07/05/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

// sourcery: AutoMockable
public protocol SparkFeatureToggleServicing {
    var rebranding: Bool { get set }
}

public struct SparkFeatureToggleService: SparkFeatureToggleServicing {

    // MARK: - Static Properties

    public static var shared: any SparkFeatureToggleServicing = SparkFeatureToggleService()

    // MARK: - Properties

    public var rebranding: Bool = false

    // MARK: - Initialization

    private init() {
    }

    // MARK: - Static Func

    @_spi(SI_SPI) public static func reset() {
        self.shared = SparkFeatureToggleService()
    }
}

//
//  SparkFeatureToggleServiceTests.swift
//  SparkCommonTests
//
//  Created on 07/05/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Testing
@_spi(SI_SPI) @testable import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting

@Suite("SparkFeatureToggleService Tests", .serialized)
struct SparkFeatureToggleServiceTests {

    // MARK: - Tests

    @Test("Shared instance should have default values")
    func shared_instance_default_values() {
        // GIVEN / WHEN
        let service = SparkFeatureToggleService.shared

        // THEN
        #expect(service is SparkFeatureToggleService, "service should be an instance of SparkFeatureToggleService")
        #expect(!service.appearence, "appearence should be false by default")
        #expect(!service.rebranding, "rebranding should be false by default")
        #expect(!service.visualIdentification, "visualIdentification should be false by default")
    }

    @Test("Appearence setter should update the property value")
    func appearence_setter() {
        // GIVEN
        SparkFeatureToggleService.shared.appearence = true

        // WHEN
        let result = SparkFeatureToggleService.shared.appearence

        // THEN
        #expect(result, "appearence getter should return the set value")
    }

    @Test("Rebranding setter should update the property value")
    func rebranding_setter() {
        // GIVEN
        SparkFeatureToggleService.shared.rebranding = true

        // WHEN
        let result = SparkFeatureToggleService.shared.rebranding

        // THEN
        #expect(result, "rebranding getter should return the set value")
    }

    @Test("VisualIdentification setter should update the property value")
    func visualIdentification_setter() {
        // GIVEN
        SparkFeatureToggleService.shared.visualIdentification = true

        // WHEN
        let result = SparkFeatureToggleService.shared.visualIdentification

        // THEN
        #expect(result, "visualIdentification getter should return the set value")
    }

    @Test("Shared instance should be replaceable")
    func shared_instance_replaceable() {
        // GIVEN
        let mockService = SparkFeatureToggleServicingGeneratedMock()
        mockService.appearence = true
        mockService.rebranding = true
        mockService.visualIdentification = true

        // WHEN
        SparkFeatureToggleService.shared = mockService

        // THEN
        #expect(SparkFeatureToggleService.shared.appearence, "shared instance should be replaceable with a mock")
        #expect(SparkFeatureToggleService.shared.rebranding, "shared instance should be replaceable with a mock")
        #expect(SparkFeatureToggleService.shared.visualIdentification, "shared instance should be replaceable with a mock")
        #expect(SparkFeatureToggleService.shared is SparkFeatureToggleServicingGeneratedMock, "shared instance should be of type SparkFeatureToggleServicingGeneratedMock")
    }

    @Test("Shared instance should reset from mock to default service")
    func shared_instance_reset_from_mock() {
        // GIVEN
        let mockService = SparkFeatureToggleServicingGeneratedMock()
        mockService.appearence = true
        mockService.rebranding = true
        mockService.visualIdentification = true
        SparkFeatureToggleService.shared = mockService
        #expect(SparkFeatureToggleService.shared is SparkFeatureToggleServicingGeneratedMock, "shared instance should be a mock before reset")

        // WHEN
        SparkFeatureToggleService.reset()

        // THEN
        #expect(SparkFeatureToggleService.shared is SparkFeatureToggleService, "shared instance should be of type SparkFeatureToggleService after reset")
        #expect(!SparkFeatureToggleService.shared.appearence, "appearence should be false after reset")
        #expect(!SparkFeatureToggleService.shared.rebranding, "rebranding should be false after reset")
        #expect(!SparkFeatureToggleService.shared.visualIdentification, "visualIdentification should be false after reset")
    }
}

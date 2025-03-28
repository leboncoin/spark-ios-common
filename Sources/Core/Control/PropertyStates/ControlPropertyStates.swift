//
//  ControlPropertyStates.swift
//  SparkCommon
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation

/// Manage all the states for a dynamic property.
@_spi(SI_SPI) public final class ControlPropertyStates<PropertyType: Equatable> {

    // MARK: - Type Alias

    private typealias PropertyState = ControlPropertyState<PropertyType>

    // MARK: - Properties

    private var normalState = PropertyState(for: .normal)
    private var highlightedState = PropertyState(for: .highlighted)
    private var disabledState = PropertyState(for: .disabled)
    private var selectedState = PropertyState(for: .selected)

    // MARK: - Setter

    /// Set the new value for a state.
    /// - Parameters:
    ///   - value: the new value
    ///   - state: the state for the new value
    public func setValue(_ value: PropertyType?, for state: ControlState) {
        let propertyState: PropertyState

        switch state {
        case .normal:
            propertyState = self.normalState
        case .highlighted:
            propertyState = self.highlightedState
        case .disabled:
            propertyState = self.disabledState
        case .selected:
            propertyState = self.selectedState
        }

        propertyState.value = value
    }

    // MARK: - Getter

    /// Get the value for a state.
    /// - Parameters:
    ///   - state: the state of the value
    public func value(for state: ControlState) -> PropertyType? {
        switch state {
        case .normal: return self.normalState.value
        case .highlighted: return self.highlightedState.value
        case .disabled: return self.disabledState.value
        case .selected: return self.selectedState.value
        }
    }

    /// Get the value for the status of the control.
    /// - Parameters:
    ///   - status: the status of the control
    public func value(for status: ControlStatus) -> PropertyType? {
        // isHighlighted has the highest priority,
        // then isDisabled,
        // then isSelected,
        // and if there is no matching case, we always return the normal value.

        if status.isHighlighted, let value = self.highlightedState.value {
            return value
        } else if !status.isEnabled, let value = self.disabledState.value {
            return value
        } else if status.isSelected, let value = self.selectedState.value {
            return value
        } else {
            return self.normalState.value
        }
    }
}

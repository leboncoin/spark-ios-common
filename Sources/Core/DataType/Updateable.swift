//
//  Updateable.swift
//  Spark
//
//  Created by michael.zimmermann on 25.07.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming

public protocol Updateable {
    associatedtype T
    func update<Value>(_ keyPath: WritableKeyPath<T, Value>, value: Value) -> T
    func updateIfNeeded<Value: Equatable>(keyPath: ReferenceWritableKeyPath<T, Value>, newValue: Value)
    func updateIfNeeded(keyPath: ReferenceWritableKeyPath<T, any ColorToken>, newValue: any ColorToken)
}

@_spi(SI_SPI) public extension Updateable {
    func update<Value>(_ keyPath: WritableKeyPath<Self, Value>, value: Value) -> Self {

        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }

    func updateIfNeeded<Value: Equatable>(keyPath: ReferenceWritableKeyPath<Self, Value>, newValue: Value) {
        guard self[keyPath: keyPath] != newValue else { return }
        self[keyPath: keyPath] = newValue
    }

    func updateIfNeeded(keyPath: ReferenceWritableKeyPath<Self, any ColorToken>, newValue: any ColorToken) {
        guard self[keyPath: keyPath].equals(newValue) == false else { return }
        self[keyPath: keyPath] = newValue
    }
}

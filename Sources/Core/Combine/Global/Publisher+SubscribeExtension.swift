//
//  Publisher+SubscribeExtension.swift
//  SparkCommon
//
//  Created by michael.zimmermann on 05.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

@_spi(SI_SPI) public extension Publisher where Failure == Never {
    func subscribe<S>(
        in subscriptions: inout Set<AnyCancellable>,
        on scheduler: S = UIScheduler.shared,
        action: @escaping (Self.Output) -> Void ) where S: Scheduler {
            self
                .receive(on: scheduler)
                .sink { value in
                    action(value)
                }
                .store(in: &subscriptions)
    }
}

//
//  UIView+CornerRadiusExtensionSnapshotTests.swift
//  SparkCommon
//
//  Created by robin.lemaire on 01/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import UIKit
@testable import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting

final class UIViewCornerRadiusExtensionSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Tests

    func test_with_default_properties() {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(),
            UILabel.label1,
            UILabel.label2,
            UIView()
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let backgroundView = UIView()
        backgroundView.backgroundColor = .secondarySystemBackground
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalToConstant: 200),
            backgroundView.heightAnchor.constraint(equalToConstant: 100)
        ])
        backgroundView.addSubview(stackView)
        NSLayoutConstraint.stickEdges(
            from: stackView,
            to: backgroundView,
            insets: .init(all: 20)
        )

        self.assertSnapshot(
            matching: backgroundView,
            modes: ComponentSnapshotTestConstants.Modes.default,
            sizes: ComponentSnapshotTestConstants.Sizes.default
        )
    }
}

// MARK: - Extension

private extension UILabel {

    static let label1: UILabel = {
        let label = UILabel()
        label.text = "Hey"
        label.backgroundColor = .yellow
        label.cornerRadius(10)
        return label
    }()

    static let label2: UILabel = {
        let label = UILabel()
        label.text = "Bye"
        label.backgroundColor = .green
        label.cornerRadius(10, isHighlighted: true)
        return label
    }()
}

private extension UIView {

    func setStyle() {
        self.backgroundColor = .secondarySystemBackground
        self.frame.size.width = 200
        self.frame.size.height = 100
    }
}

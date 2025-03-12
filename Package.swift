// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "SparkCommon",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SparkCommon",
            targets: ["SparkCommon"]
        ),
        .library(
            name: "SparkCommonTesting",
            targets: ["SparkCommonTesting"]
        ),
        .library(
            name: "SparkCommonSnapshotTesting",
            targets: ["SparkCommonSnapshotTesting"]
        )
    ],
    dependencies: [
        // Leboncoin
        .package(
            url: "https://github.com/leboncoin/spark-ios-theming.git",
            // path: "../spark-ios-theming"
            /*version*/ "0.0.1"..."999.999.999"
        ),

        // External
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.11.0"
        )
    ],
    targets: [
        .target(
            name: "SparkCommon",
            dependencies: [
                .product(
                    name: "SparkTheming",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "SparkCommonTesting",
            dependencies: [
                "SparkCommon",
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SparkTheme",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Testing"
        ),
        .target(
            name: "SparkCommonSnapshotTesting",
            dependencies: [
                "SparkCommon",
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SparkTheme",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                ),
            ],
            path: "Sources/SnapshotTesting"
        ),
        .testTarget(
            name: "SparkCommonUnitTests",
            dependencies: [
                "SparkCommon",
                "SparkCommonTesting"
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "SparkCommonSnapshotTests",
            dependencies: [
                "SparkCommon",
                "SparkCommonSnapshotTesting",
                "SparkCommonTesting"
            ],
            path: "Tests/SnapshotTests"
        )
    ]
)

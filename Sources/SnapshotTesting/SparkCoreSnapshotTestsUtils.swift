//
//  SparkCoreSnapshotTestsUtils.swift
//  SparkCoreTests
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
@_implementationOnly import SnapshotTesting

@_spi(SI_SPI) public func sparkAssertSnapshot<Value, Format>(
    matching value: @autoclosure () throws -> Value,
    as snapshotting: Snapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    forDocumentation: Bool = false
) {
    let tracker = SnapshotTestCaseTracker.shared
    let directory = forDocumentation ? tracker.snapshotDocumentationDirectory(for: file) : tracker.snapshotDirectory(for: file)

    let failure = verifySnapshot(
        of: try value(),
        as: snapshotting,
        named: name,
        record: forDocumentation ? true : recording,
        snapshotDirectory: directory,
        timeout: timeout,
        file: file,
        testName: testName
    )

    // No failure if the snapshots is for documentation
    if forDocumentation {
        renameDocumentationSnapshots(
            directoryPath: directory,
            named: name,
            testName: testName
        )
    } else {
        guard let message = failure else { return }
        XCTFail("\(message): \(testName)", file: file, line: line)
    }
}

// swiftlint:disable no_debugging_method
private func renameDocumentationSnapshots(
    directoryPath: String,
    named name: String?,
    testName: String
) {
    let fileManager = FileManager.default

    do {
        let filename = testName + "." + (name ?? "")

        var filePath = directoryPath + filename + ".png"
        filePath.replace(".-", with: ".")

        if fileManager.fileExists(atPath: filePath) {

            // Resyntax the name of the file
            var destinationFilePath = filePath
            destinationFilePath.replace(".light", with: "")
            destinationFilePath.replace(".dark", with: "~dark")
            destinationFilePath.replace("-2x", with: "@2x")

            var destination1xFilePath = destinationFilePath
            destination1xFilePath.replace("@2x", with: "")

            let fileURL = URL(fileURLWithPath: filePath)

            let destinationURL = URL(fileURLWithPath: destinationFilePath)
            let destination1xURL = URL(fileURLWithPath: destination1xFilePath)

            // Remove the snapshot if the file exists
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }

            // Add the new snapshot file
            try fileManager.moveItem(at: fileURL, to: destinationURL)
            try fileManager.copyItem(at: destinationURL, to: destination1xURL)
        }
    } catch {
        print("[Move Documentation] Error \(error)")
    }
}

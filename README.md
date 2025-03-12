# Configuration

## Introduction

Spark is [Leboncoin’s](https://www.leboncoin.com/) iOS Design System.

Its mission is to provide an easy to use, customizable UI experience for consumers.

This repository contains a SPM (Swift Package Manager) to manage the common code using by all Spark iOS repositories.
It also contains the snapshot testing strategy with the external `swift-snapshot-testing` dependencies.

**Note**: A customer is not supposed to have access to this code.

## SPM

To open the project on Xcode, you just need to double click on the `Package.swift`.

The SPM is composed by

- Targets (all are protected by @\_spi annotation to be accessible just be the Spark team.) :

  - **SparkCommon**: Common public code.
  - **SparkCommonSnapshotTesting**: Public snapshot test cases, mock and extensions.
  - **SparkCommonTesting**: Public protocols mocks

- Unit Tests:
  - **SparkCommonSnapshotTests**: Unit tests for the Common Snapshot target
  - **SparkCommonUnitTests**: Unit tests for the Common target

## Guidelines

There is two importants rules for this repository:

- All `protocols`, `class`, `struct`, `var/let/func`, ..., used by at least one component (or other) in **`public`** or **`open`**.
- If the code can be used only by the **spark iOS team**, all `public` or **`open`** must contains the **`@_spi(SI_SPI)`** annotation. If the code can also be used by consommer too, you don't need to add this annotation.

## License

```
MIT License

Copyright (c) 2024 Leboncoin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

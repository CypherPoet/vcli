# VCLI

<!-- Header Logo -->

<!--
<div align="center">
   <img width="600px" src="./Sources/VCLI/VCLI.docc/Resources/Images/banner-logo.png" alt="Banner Logo">
</div>

 -->

<!-- Badges -->

<p>

[![Swift Version Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvaleralabs%2FVCLI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/valeralabs/VCLI)

[![Swift Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvaleralabs%2FVCLI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/valeralabs/VCLI)

</p>

<p>
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
    <img src="https://github.com/valeralabs/VCLI/workflows/Build%20&%20Test/badge.svg" />
    <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" />
    </a>
    <a href="https://twitter.com/valeralabs">
        <img src="https://img.shields.io/badge/Contact-@valeralabs-lightgrey.svg?style=flat" alt="Twitter: @valeralabs" />
    </a>
</p>

<p align="center">

_A simple demo for VDK._

</p>

## Installation

### Xcode Projects

Select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/valeralabs/VCLI`.

### Swift Package Manager Projects

You can add `VCLI` as a package dependency in your `Package.swift` file:

```swift
let package = Package(
    //...
    dependencies: [
        .package(
            url: "https://github.com/valeralabs/vcli",
            .exact("0.0.1")
        ),
    ],
    //...
)
```

From there, refer to the `VCLI` "product" delivered by the `VCLI` "package" inside of any of your project's target dependencies:

```swift
targets: [
    .target(
        name: "YourLibrary",
        dependencies: [
            .product(
                name: "VCLI",
                package: "vcli"
            ),
        ],
        ...
    ),
    ...
]
```

<!-- Proceed from above choice accordingly (and delete this comment) -->

Then simply `import VCLI` wherever you’d like to use it.

## Usage

## 🗺 Roadmap

- World Domination

## 💻 Developing

### Requirements

- Xcode 13.0+

Documentation is built with [DocC](https://developer.apple.com/documentation/docc) (see [Apple's guidance for more details about creating DocC content](https://developer.apple.com/documentation/docc/api-reference-syntax)).

To build and preview the documentation output, follow the instructions for the [here](https://github.com/apple/swift-docc-plugin#previewing-documentation) for the `Swift-DocC Plugin`.

If you're using VSCode, there's also a [task configuration](./.vscode/tasks.json) that will handle this directly from the editor 💪

## 🏷 License

`VCLI` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

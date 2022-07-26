// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VCLI",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "VCLI",
            targets: ["VCLI"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            "1.0.0" ..< "2.0.0"
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            "1.0.0" ..< "2.0.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package.
        // A target can define a module or a test suite.
        //
        // Targets can depend on other targets in this package,
        // and on products in packages which this package depends on.
        .executableTarget(
            name: "VCLI",
            dependencies: [
                "VDK",
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
            ],
            path: "Sources/VCLI/",
            exclude: [
                "Resources/README.txt",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "VCLITests",
            dependencies: [
                "VCLI",
            ],
            path: "Tests/VCLI/",
            exclude: [
                "Resources/README.md",
                "Toolbox/README.md",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        
        .binaryTarget(
            name: "VDK",
            path: "Artifacts/VDK.xcframework"
        ),
    ]
)

// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUtil",
    products: [
        .library(
            name: "SwiftUtil",
            targets: ["SwiftUtil"]),
    ],
    targets: [
        .target(
            name: "SwiftUtil",
            dependencies: []),
        .testTarget(
            name: "SwiftUtilTests",
            dependencies: ["SwiftUtil"]),
    ]
)

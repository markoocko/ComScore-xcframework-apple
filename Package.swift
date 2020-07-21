// swift-tools-version:5.3

import PackageDescription

struct PackageMetadata {
    static let version: String = "6.5.0"
    static let checksum: String = "748fd4bd7c6ddaa073e18e14966d0883a4bc55c35e6e0270c7c153e3d9a9a1f2"
}

let package = Package(
    name: "ComScore",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "ComScore",
            type: .dynamic,
            targets: ["ComScore"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "ComScore",
            url: "https://github.com/SRGSSR/ComScore-xcframework-apple/releases/download/\(PackageMetadata.version)/ComScore.xcframework.zip",
            checksum: PackageMetadata.checksum
        )
    ]
)

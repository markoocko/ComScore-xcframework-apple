// swift-tools-version:5.3

import PackageDescription

struct PackageMetadata {
    static let version: String = "6.5.0"
    static let checksum: String = ""
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

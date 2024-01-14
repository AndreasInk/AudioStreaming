// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "AudioStreaming",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "AudioStreaming",
            targets: ["AudioStreaming"]
        ),
    ],
    targets: [
        .target(
            name: "AudioStreaming",
            path: "AudioStreaming"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

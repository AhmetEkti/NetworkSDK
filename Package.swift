// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NetworkSDK",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NetworkSDK",
            type: .dynamic,
            targets: ["NetworkSDK"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "NetworkSDK",
            dependencies: [],
            path: "Sources/NetworkSDK"),
        .testTarget(
            name: "NetworkSDKTests",
            dependencies: ["NetworkSDK"],
            path: "Tests/NetworkSDKTests")
    ],
    swiftLanguageVersions: [.v5]
)
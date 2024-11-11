//
//  Package.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import PackageDescription

let package = Package(
    name: "NetworkSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NetworkSDK",
            targets: ["NetworkSDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkSDK",
            dependencies: []),
        .testTarget(
            name: "NetworkSDKTests",
            dependencies: ["NetworkSDK"]),
    ]
)

// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Plug",
    platforms: [.iOS(.v8)],
    products: [.library(name: "Plug", targets: ["Plug"])],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.7.1")
    ],
    targets: [
        .target(name: "Plug", dependencies:["Swinject"]),
        .testTarget(name: "PlugTests", dependencies: ["Plug"])
    ]
)

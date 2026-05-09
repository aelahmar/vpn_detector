// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "vpn_detector",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "vpn-detector", targets: ["vpn_detector"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "vpn_detector",
            path: "Sources/vpn_detector"
        )
    ]
)

// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "OneAudit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "OneAudit",
            targets: ["OneAudit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/avgx/RequestResponse", from: "2.0.1"),
        .package(url: "https://github.com/avgx/OneWireFormat", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "OneAudit",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "OneWireFormat", package: "OneWireFormat"),
            ]
        ),
        .testTarget(
            name: "OneAuditTests",
            dependencies: [
                "OneAudit",
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "OneWireFormat", package: "OneWireFormat"),
            ]
        ),
    ]
)

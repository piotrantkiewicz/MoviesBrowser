// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
        .library(
            name: "MBCore",
            targets: ["MBCore"]),
        .library(
            name: "MBMovies",
            targets: ["MBMovies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.1")),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "MBCore"
        ),
        .target(
            name: "MBMovies",
            dependencies: [
                "DesignSystem",
                "MBCore",
                "SDWebImage",
                "SnapKit",
                "Swinject",
            ]
        ),
        .testTarget(
            name: "MBMoviesTests",
            dependencies: [
                "MBMovies",
                "Swinject"
            ]
        ),
    ]
)

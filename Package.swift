// swift-tools-version: 6.2

// © 2025–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "IvorJohnnySonic",
                      platforms: [.iOS(.v18),
                                  .macOS(.v15)],
                      products: [.library(name: "IvorJohnnySonic",
                                          targets: ["IvorJohnnySonic"])],
                      dependencies: [.package(url: "https://github.com/swiftlang/swift-docc-plugin.git",
                                              .upToNextMajor(from: "1.1.0")),
                                     .package(url: "https://github.com/eBardX/XestiTools.git",
                                              .upToNextMajor(from: "7.2.0"))],
                      targets: [.target(name: "IvorJohnnySonic",
                                        dependencies: [.product(name: "XestiTools",
                                                                package: "XestiTools")]),
                                .testTarget(name: "IvorJohnnySonicTests",
                                            dependencies: [.target(name: "IvorJohnnySonic")])],
                      swiftLanguageModes: [.v6])

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}

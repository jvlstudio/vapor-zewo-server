import PackageDescription

let package = Package(
    name: "VaporZewoServer",
    dependencies: [
        .Package(url: "https://github.com/Zewo/HTTPServer.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0)
    ]
)

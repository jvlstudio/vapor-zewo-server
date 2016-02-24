import PackageDescription

let package = Package(
    name: "VaporZewoServer",
    dependencies: [
        .Package(url: "https://github.com/Zewo/HTTPServer.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),

        //temporary package dependencies due to SPM bug
        .Package(url: "https://github.com/Zewo/CURIParser.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/CHTTPParser.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/CLibvenice.git", majorVersion: 0),
    ]
)

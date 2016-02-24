# Vapor Zewo Server

Use Zewo's HTTPServer in your Vapor application.

## Add Package

Include the package as a dependency to your project.

```swift
import PackageDescription

let package = Package(
    name: "VaporApp",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
        .Package(url: "https://github.com/qutheory/vapor-zewo-server.git", majorVersion: 0)
    ]
)
```

## Add Provider

Once the package is included, import it and add the Provider.

```swift
import VaporZewoServer

app.providers.append(VaporZewoServer.Provider)
```
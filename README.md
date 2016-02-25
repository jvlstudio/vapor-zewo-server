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

## Dependencies

Zewo has a few C dependencies that need to be installed.

### OS X
```shell
brew tap zewo/tap
brew install libvenice
brew install http_parser
brew install uri_parser
```

You may also need to run `brew link --overwrite http_parser` if you have been working with `http-parser`.

### Linux
```shell
echo "deb [trusted=yes] http://apt.zewo.io/deb ./" | sudo tee --append /etc/apt/sources.list
sudo apt-get update
sudo apt-get install libvenice
sudo apt-get install http-parser
sudo apt-get install uri-parser
```
ComScore XCFramework
====================

XCFramework binaries are currently not provided by comScore. Until they are this repository provides XCFrameworks for versions we use at SRG SSR, with a Swift Package Manager manifest for easy integration in projects. Binaries are currently packaged for iOS, tvOS and watchOS.

## Integration

Use [Swift Package Manager](https://swift.org/package-manager) directly [within Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app). You can also declare the library as a dependency of another one directly in the associated `Package.swift` manifest.

## Generation

comScore binaries are publicly available from the [dedicated repository](https://github.com/comScore/ComScore-iOS-watchOS-tvOS), though as separate frameworks for all platforms. A bit of manual work is required to publish a new version.

### Building the XCFramework

To build the XCFramework:

1. Clone the ComScore main binary repository: `$ git clone https://github.com/comScore/ComScore-iOS-watchOS-tvOS.git`.
2. Switch to the tag you want to produce an XCFramework for: `$ git switch --detach <tag>`
3. Use the script to package the framework, providing the checked out repository path as parameter: `$ ./comscore_xcframework.sh /path/to/repository`

If everything goes well a zip of the XCFramework will be generated where the script was executed, with the corresponding checksum displayed. **Save the binary zip and the checksum somewhere safe.**

### Make the XCFramework available

To make the generated framework available:

1. Update the `Package.swift` in this repository with the framework version number and the checksum of the zip you just generated.
2. Commit the changes on `master` and create a corresponding tag.
3. Push the commit and the tag to GitHub.
4. Attach the binary to the tag on GitHub.

Do not commit the binaries in the repository, as this would slow done checkouts made by SPM as the repostory grows.
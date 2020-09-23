#!/bin/bash

execution_dir=`pwd`

xcframework_name="ComScore.xcframework"
xcframework_zip_name="$xcframework_name.zip"

xcframework_path="$execution_dir/$xcframework_name"
package_file_path="$execution_dir/Package.swift"

framework_dir="$1/ComScore/dynamic"
if [ ! -d "$framework_dir" ]; then
    echo "Please provide a correct comScore local repository file path"
    exit 0
fi

pushd "$framework_dir" > /dev/null

rm -rf "$xcframework_path"

echo "Extracting slices..."
mkdir -p variants/iphoneos
cp -R iOS/ComScore.framework variants/iphoneos
lipo -remove i386 -remove x86_64 -output variants/iphoneos/ComScore.framework/ComScore variants/iphoneos/ComScore.framework/ComScore

mkdir -p variants/iphonesimulator
cp -R iOS/ComScore.framework variants/iphonesimulator
lipo -remove armv7 -remove arm64 -output variants/iphonesimulator/ComScore.framework/ComScore variants/iphonesimulator/ComScore.framework/ComScore

mkdir -p variants/appletvos
cp -R tvOS/ComScore.framework variants/appletvos
lipo -remove x86_64 -output variants/appletvos/ComScore.framework/ComScore variants/appletvos/ComScore.framework/ComScore

mkdir -p variants/appletvsimulator
cp -R tvOS/ComScore.framework variants/appletvsimulator
lipo -remove arm64 -output variants/appletvsimulator/ComScore.framework/ComScore variants/appletvsimulator/ComScore.framework/ComScore

mkdir -p variants/watchos
cp -R watchOS/ComScore.framework variants/watchos
lipo -remove i386 -remove x86_64 -output variants/watchos/ComScore.framework/ComScore variants/watchos/ComScore.framework/ComScore

mkdir -p variants/watchsimulator
cp -R watchOS/ComScore.framework variants/watchsimulator
lipo -remove armv7k -remove arm64_32 -output variants/watchsimulator/ComScore.framework/ComScore variants/watchsimulator/ComScore.framework/ComScore

echo "Packaging XCFramework..."
xcodebuild -create-xcframework \
    -framework variants/iphoneos/ComScore.framework \
    -framework variants/iphonesimulator/ComScore.framework \
    -framework variants/appletvos/ComScore.framework \
    -framework variants/appletvsimulator/ComScore.framework \
    -framework variants/watchos/ComScore.framework \
    -framework variants/watchsimulator/ComScore.framework \
    -output "$xcframework_path"

rm -rf variants
popd > /dev/null

pushd $execution_dir > /dev/null

zip -r "$xcframework_zip_name" "$xcframework_name" > /dev/null
rm -rf "$xcframework_name"

# Currently a Package.swift file must be found for the command to succeed
dummy_package_file_created=false
if [ ! -f "$package_file_path" ]; then
    touch "$package_file_path"
    dummy_package_file_created=true
fi

hash=`swift package compute-checksum "$xcframework_zip_name"`

echo ""
echo "The zip hash is $hash"
echo ""
echo "Please keep the zip and its hash in a safe place, as regenerating a new zip will produce a new hash."

if $dummy_package_file_created; then
    rm "$package_file_path"
fi

popd > /dev/null

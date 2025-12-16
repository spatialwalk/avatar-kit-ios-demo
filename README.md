## AvatarKit iOS Demo

The xcworkspace contains two example applications demonstrating different use cases of the AvatarKit:

- **SDKExample**: Demonstrates sdk driving service mode
- **HostExample**: Demonstrates host driving service mode

For more details, see the [AvatarKit Docs](https://docs.spatialreal.ai).

## Requirements

- iOS 16.0+
- Xcode 26.0+
- iOS device required

## Integration Guide

### Step 1: Add AvatarKit.xcframework

1. Drag `AvatarKit.xcframework` into your Xcode project
2. In the dialog, select **"Copy items if needed"**
3. In **Target > General > Frameworks, Libraries, and Embedded Content**, set AvatarKit.xcframework to **"Do Not Embed"** (because it's a static library)

### Step 2: Add Linker Flags

In **Target > Build Settings > Other Linker Flags**, add:
```
-lz
-lc++
```

### Step 3: Add Run Script Build Phase (Required)

AvatarKit contains platform-specific resources (Metal shaders) that need to be copied to the app bundle at build time.

1. In **Target > Build Phases**, click **"+"** and select **"New Run Script Phase"**
2. Rename it to **"Copy AvatarKit Resources"**
3. Paste the following script:

```bash
XCFRAMEWORK_PATH="${PROJECT_DIR}/../AvatarKit.xcframework"

if [ "${PLATFORM_NAME}" = "iphonesimulator" ]; then
  ARCH_DIR="ios-arm64-simulator"
else
  ARCH_DIR="ios-arm64"
fi

RESOURCE_BUNDLE="${XCFRAMEWORK_PATH}/${ARCH_DIR}/AvatarKit.framework/AvatarKitResources.bundle"

if [ -d "${RESOURCE_BUNDLE}" ]; then
  cp -R "${RESOURCE_BUNDLE}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/"
  echo "Copied AvatarKitResources.bundle to ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/"
else
  echo "Warning: Resource bundle not found at ${RESOURCE_BUNDLE}"
fi
```

> **Note**: Adjust `XCFRAMEWORK_PATH` to match the actual location of AvatarKit.xcframework relative to your project directory.

### Step 4: Import and Use

```swift
import AvatarKit

// Initialize and use AvatarKit
```

## Running the Demo

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/avatar-kit-ios-demo.git
cd avatar-kit-ios-demo
```

### 2. Open the xcworkspace

```bash
open Example.xcworkspace
```

### 3. Input Avatar ID

**~/SDKExample/AvatarViewModel.swift**:
```swift
let avatarID: String = ""
```

**~/HostExample/AvatarViewModel.swift**:
```swift
let avatarID: String = ""
```

> See [Test Avatars](https://docs.spatialreal.ai/overview/test-avatars) for available avatar IDs.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

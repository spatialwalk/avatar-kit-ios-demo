## AvatarKit iOS Demo

The xcworkspace contains two example applications demonstrating different use cases of the AvatarKit:

- **SDKExample**: Demonstrates sdk driving service mode
- **HostExample**: Demonstrates host driving service mode

For more details, see the [AvatarKit Docs](https://docs.spatialreal.ai).

## Requirements

- iOS 16.0+
- Xcode 26.0+
- iOS device required

## Getting Started

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

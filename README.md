# VPN Detector 🛡️

A package created out of a real need for precuse VPN detection on iOS and Android devices.

## Features 🎛️

- ✅ Detects iOS and Android VPN connections in a reliable manner.
- 🧪 Fully testable code with no static methods, facilitating a TDD approach.

## Usage 🔧

Using the VPN Detector package is straightforward. Simply import the package into your project and use the following code snippet to check if a VPN connection is active:

```dart
import 'package:vpn_detector/vpn_detector.dart';

final isVpnActive = await VpnDetector().isVpnActive();
```

## Contributing 👨‍💻

You can contribute by either:
1. Making a Pull Request 🛠️
2. Opening an Issue 🐛
 
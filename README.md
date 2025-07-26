# VPN Detector 🛡️

[![Pub Version](https://img.shields.io/pub/v/vpn_detector)](https://pub.dev/packages/vpn_detector)  
[![codecov](https://codecov.io/github/aelahmar/vpn_detector/graph/badge.svg?token=090RC225BD)](https://codecov.io/github/aelahmar/vpn_detector)

A Flutter package for reliable VPN detection on iOS and Android, featuring a clean, testable API and real-time status updates.

## Features

- ✅ **VPN Status**: Check if a VPN connection is active, returning a `VpnStatus` enum (`active` or `notActive`).
- 🔄 **Real-time Updates**: Listen to the `onVpnStatusChanged` stream to react whenever the VPN status changes.
- 🧪 **Testable by Design**: Use `VpnDetector.withDependencies(...)` and `@visibleForTesting` hooks to inject fakes in your TDD suite.
- 📦 **Zero Static Calls**: No hidden singletons—inject both `Connectivity` and the platform interface for full control.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  vpn_detector: ^<latest_version>
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Check

```dart
import 'package:vpn_detector/vpn_detector.dart';

void main() async {
  final status = await VpnDetector().isVpnActive();
  if (status == VpnStatus.active) {
    print('VPN is active');
  } else {
    print('VPN is not active');
  }
}
```

### Stream Listening

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vpn_detector/vpn_detector.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final VpnDetector _detector;
  late StreamSubscription<VpnStatus> _sub;
  VpnStatus _status = VpnStatus.notActive;

  @override
  void initState() {
    super.initState();
    _detector = VpnDetector();
    _sub = _detector.onVpnStatusChanged.listen((status) {
      setState(() => _status = status);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_status == VpnStatus.active ? 'ACTIVE' : 'NOT ACTIVE');
  }
}
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.
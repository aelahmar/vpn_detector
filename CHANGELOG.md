## 1.2.0

### Breaking Changes
- Changed `VpnDetector.isVpnActive()` return type from `Future<bool>` to `Future<VpnStatus>`, introducing the `VpnStatus` enum.

### Added
- Introduced `VpnStatus` enum with values `active` and `notActive`.
- Added `onVpnStatusChanged` stream for real-time VPN status updates.
- Added `VpnDetector.withDependencies(...)` constructor (annotated `@visibleForTesting`) for dependency injection and TDD.

## 1.1.1

### What's Changed

- Documentation dart api

## 1.1.0

### What's Changed

- **Android**: Updated to `compileSdk=35`, `minSdk=21`, `targetSdk=35`.
- **iOS**: Minimum deployment target set to `iOS 13.0`, Swift `5`.

## 1.0.1

### What's Changed

- Enhanced documentation in the README.md
- Upgraded dependencies to the latest versions
- Add more tests for `vpn_detector_method_channel_test.dart`

## 1.0.0

### What's Changed

- Detect VPN active connections on Android and IOS Platforms

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import 'vpn_detector_platform_interface.dart';

/// Status of the VPN connection.
enum VpnStatus {
  /// VPN is active.
  active,

  /// VPN is not active.
  notActive,
}

/// A utility to detect VPN status and react to connectivity changes.
class VpnDetector {
  /// Creates a [VpnDetector] with default dependencies.
  factory VpnDetector() => VpnDetector.withDependencies(
        connectivity: Connectivity(),
        platform: VpnDetectorPlatform.instance,
      );

  /// Creates a [VpnDetector] with injected dependencies for testing.
  @visibleForTesting
  VpnDetector.withDependencies({
    required Connectivity connectivity,
    required VpnDetectorPlatform platform,
  })  : _connectivity = connectivity,
        _platform = platform;

  final Connectivity _connectivity;
  final VpnDetectorPlatform _platform;

  /// Checks whether VPN is active, returning a [VpnStatus].
  Future<VpnStatus> isVpnActive() async {
    final bool active = await _platform.isVpnActive();
    return active ? VpnStatus.active : VpnStatus.notActive;
  }

  /// A stream of [VpnStatus] that updates whenever the connectivity changes.
  Stream<VpnStatus> get onVpnStatusChanged =>
      _connectivity.onConnectivityChanged.asyncMap((_) => isVpnActive());
}

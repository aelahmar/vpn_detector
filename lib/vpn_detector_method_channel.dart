import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'vpn_detector_platform_interface.dart';

/// An implementation of [VpnDetectorPlatform] that uses method channels.
class MethodChannelVpnDetector extends VpnDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('vpn_detector');

  @override
  Future<bool> isVpnActive() async {
    final isActive = await methodChannel.invokeMethod<bool>('isVpnActive');
    return isActive ?? false;
  }
}

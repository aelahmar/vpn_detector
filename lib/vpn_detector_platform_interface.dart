import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'vpn_detector_method_channel.dart';

abstract class VpnDetectorPlatform extends PlatformInterface {
  /// Constructs a VpnDetectorPlatform.
  VpnDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static VpnDetectorPlatform _instance = MethodChannelVpnDetector();

  /// The default instance of [VpnDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelVpnDetector].
  static VpnDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VpnDetectorPlatform] when
  /// they register themselves.
  static set instance(VpnDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isVpnActive() {
    throw UnimplementedError('isVpnActive() has not been implemented.');
  }
}

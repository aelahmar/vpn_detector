import 'vpn_detector_platform_interface.dart';

class VpnDetector {
  Future<bool> isVpnActive() {
    return VpnDetectorPlatform.instance.isVpnActive();
  }
}

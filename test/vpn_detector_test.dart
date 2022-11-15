import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:vpn_detector/vpn_detector.dart';
import 'package:vpn_detector/vpn_detector_method_channel.dart';
import 'package:vpn_detector/vpn_detector_platform_interface.dart';

class MockVpnDetectorPlatform
    with MockPlatformInterfaceMixin
    implements VpnDetectorPlatform {
  @override
  Future<bool> isVpnActive() => Future.value(false);
}

void main() {
  final VpnDetectorPlatform initialPlatform = VpnDetectorPlatform.instance;

  test('$MethodChannelVpnDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVpnDetector>());
  });

  test('isVpnActive', () async {
    VpnDetector vpnDetectorPlugin = VpnDetector();
    MockVpnDetectorPlatform fakePlatform = MockVpnDetectorPlatform();
    VpnDetectorPlatform.instance = fakePlatform;

    expect(await vpnDetectorPlugin.isVpnActive(), false);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:vpn_detector/vpn_detector_method_channel.dart';
import 'package:vpn_detector/vpn_detector_platform_interface.dart';

/// Doesn’t override isVpnActive()
class IncompletePlatform extends VpnDetectorPlatform
    with MockPlatformInterfaceMixin {}

/// Doesn’t extend the interface
class InvalidPlatform implements VpnDetectorPlatform {
  @override
  Future<bool> isVpnActive() async => false;
}

void main() {
  group('VpnDetectorPlatform interface', () {
    test('default instance is MethodChannelVpnDetector', () {
      expect(VpnDetectorPlatform.instance, isA<MethodChannelVpnDetector>());
    });

    test('setting invalid instance throws AssertionError', () {
      expect(() => VpnDetectorPlatform.instance = InvalidPlatform(),
          throwsA(isA<AssertionError>()));
    });

    test('setting valid instance succeeds', () {
      final pl = IncompletePlatform();
      VpnDetectorPlatform.instance = pl;
      expect(VpnDetectorPlatform.instance, pl);
    });

    test('base isVpnActive throws UnimplementedError', () {
      final pl = IncompletePlatform();
      expect(() => pl.isVpnActive(), throwsA(isA<UnimplementedError>()));
    });
  });
}

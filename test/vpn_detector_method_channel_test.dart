import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpn_detector/vpn_detector_method_channel.dart';

void main() {
  MethodChannelVpnDetector platform = MethodChannelVpnDetector();
  const MethodChannel channel = MethodChannel('vpn_detector');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isVpnActive', () async {
    expect(await platform.isVpnActive(), true);
  });
}

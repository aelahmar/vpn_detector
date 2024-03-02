import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpn_detector/vpn_detector_method_channel.dart';

void main() {
  late MethodChannelVpnDetector platform;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    platform = MethodChannelVpnDetector();
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(platform.methodChannel, null);
  });

  group('isVpnActive |', () {
    test(
      'verify the result of isVpnActive '
      'when platform channel returns true.',
      () async {
        TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          platform.methodChannel,
          (MethodCall methodCall) {
            if (methodCall.method == 'isVpnActive') {
              return Future.value(true);
            }

            return null;
          },
        );

        expect(await platform.isVpnActive(), true);
      },
    );

    test(
      'verify the result of isVpnActive '
      'when platform channel returns false.',
      () async {
        TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          platform.methodChannel,
          (MethodCall methodCall) {
            if (methodCall.method == 'isVpnActive') {
              return Future.value(false);
            }

            return null;
          },
        );

        expect(await platform.isVpnActive(), false);
      },
    );

    test(
      'verify the result of isVpnActive '
      'when platform channel returns null.',
      () async {
        TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          platform.methodChannel,
          (MethodCall methodCall) {
            if (methodCall.method == 'isVpnActive') {
              return Future.value(null);
            }

            return null;
          },
        );

        expect(await platform.isVpnActive(), false);
      },
    );
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpn_detector/vpn_detector_method_channel.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('vpn_detector');
  final messenger = binding.defaultBinaryMessenger;

  group('MethodChannelVpnDetector', () {
    late MethodChannelVpnDetector platform;

    setUp(() {
      platform = MethodChannelVpnDetector();
    });

    tearDown(() {
      messenger.setMockMessageHandler(channel.name, null);
    });

    test('returns true when native returns true', () async {
      messenger.setMockMessageHandler(
        channel.name,
        (message) async =>
            const StandardMethodCodec().encodeSuccessEnvelope(true),
      );
      expect(await platform.isVpnActive(), isTrue);
    });

    test('returns false when native returns false', () async {
      messenger.setMockMessageHandler(
        channel.name,
        (message) async =>
            const StandardMethodCodec().encodeSuccessEnvelope(false),
      );
      expect(await platform.isVpnActive(), isFalse);
    });

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

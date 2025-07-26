import 'dart:async';
import 'dart:collection';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:vpn_detector/vpn_detector.dart';
import 'package:vpn_detector/vpn_detector_platform_interface.dart';

/// Fake platform for controlling VPN responses.
class FakePlatform extends VpnDetectorPlatform with MockPlatformInterfaceMixin {
  final Queue<bool> _responses;
  FakePlatform(List<bool> responses)
      : _responses = Queue.of(responses),
        super();

  @override
  Future<bool> isVpnActive() async => _responses.removeFirst();
}

/// Fake connectivity for firing connectivity events.
class FakeConnectivity implements Connectivity {
  final StreamController<List<ConnectivityResult>> controller;
  FakeConnectivity(this.controller);

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      controller.stream;

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async =>
      [ConnectivityResult.none];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('VpnDetector.withDependencies', () {
    test('isVpnActive returns correct enum', () async {
      final platform = FakePlatform([true, false]);
      final detector = VpnDetector.withDependencies(
        connectivity: FakeConnectivity(StreamController()),
        platform: platform,
      );

      expect(await detector.isVpnActive(), VpnStatus.active);
      expect(await detector.isVpnActive(), VpnStatus.notActive);
    });

    test('onVpnStatusChanged streams statuses', () async {
      final controller = StreamController<List<ConnectivityResult>>();
      final platform = FakePlatform([false, true]);
      final detector = VpnDetector.withDependencies(
        connectivity: FakeConnectivity(controller),
        platform: platform,
      );

      final statuses = <VpnStatus>[];
      final sub = detector.onVpnStatusChanged.listen(statuses.add);

      controller.add([ConnectivityResult.wifi]);
      controller.add([ConnectivityResult.none]);
      await Future.delayed(Duration.zero);

      expect(statuses, [VpnStatus.notActive, VpnStatus.active]);
      await sub.cancel();
      await controller.close();
    });
  });

  group('VpnDetector default factory', () {
    late VpnDetectorPlatform old;

    setUp(() {
      old = VpnDetectorPlatform.instance;
    });
    tearDown(() {
      VpnDetectorPlatform.instance = old;
    });

    test('uses platform instance from singleton', () async {
      final fake = FakePlatform([true]);
      VpnDetectorPlatform.instance = fake;
      final detector = VpnDetector();
      expect(await detector.isVpnActive(), VpnStatus.active);
    });

    test('public constructor returns instance', () {
      expect(VpnDetector(), isA<VpnDetector>());
    });
  });
}

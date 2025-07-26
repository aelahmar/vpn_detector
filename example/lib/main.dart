import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vpn_detector/vpn_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final VpnDetector _vpnDetector;
  late StreamSubscription<VpnStatus> _subscription;
  VpnStatus _currentStatus = VpnStatus.notActive;

  @override
  void initState() {
    super.initState();
    _vpnDetector = VpnDetector();
    _initVpnStatus();
    _listenToStream();
  }

  Future<void> _initVpnStatus() async {
    final status = await _vpnDetector.isVpnActive();
    setState(() {
      _currentStatus = status;
    });
  }

  void _listenToStream() {
    _subscription = _vpnDetector.onVpnStatusChanged.listen((status) {
      setState(() {
        _currentStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VPN Detector Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'VPN is currently:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                _currentStatus == VpnStatus.active ? 'ACTIVE' : 'NOT ACTIVE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _currentStatus == VpnStatus.active
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

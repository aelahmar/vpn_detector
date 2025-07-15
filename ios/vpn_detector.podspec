Pod::Spec.new do |s|
  s.name             = 'vpn_detector'
  s.version          = '0.0.1'
  s.summary          = 'Detect VPN connection status'
  s.description      = <<-DESC
    vpn_detector is a Flutter plugin that lets your app detect whether
    the device is connected to a VPN on both Android and iOS platforms.
  DESC
  s.homepage         = 'https://pub.dev/packages/vpn_detector'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'aelahmar' => '[email protected]' }
  s.source           = { :git => 'https://github.com/aelahmar/vpn_detector.git', :tag => "#{s.version}" }
  s.platform         = :ios, '13.0'
  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'

    # Flutter.framework does not contain a i386 slice.
    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
    s.swift_version = '5.0'
end
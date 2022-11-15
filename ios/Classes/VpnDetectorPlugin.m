#import "VpnDetectorPlugin.h"
#if __has_include(<vpn_detector/vpn_detector-Swift.h>)
#import <vpn_detector/vpn_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vpn_detector-Swift.h"
#endif

@implementation VpnDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVpnDetectorPlugin registerWithRegistrar:registrar];
}
@end

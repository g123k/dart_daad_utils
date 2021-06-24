import 'dart:io';

class PlatformUtils {
  const PlatformUtils._();

  static String get platformName {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  static bool get isAComputer =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  static bool get isASmartphone => Platform.isAndroid || Platform.isIOS;

  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  static bool get isCupertino => Platform.isIOS || Platform.isMacOS;
}

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final connectivity = await Connectivity().checkConnectivity();

      Map<String, dynamic> deviceInfo = {
        'appVersion': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
        'packageName': packageInfo.packageName,
        'connectivity': connectivity.name,
      };

      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceInfo.addAll({
          'platform': 'Android',
          'osVersion': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'manufacturer': androidInfo.manufacturer,
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'hardware': androidInfo.hardware,
          'fingerprint': androidInfo.fingerprint,
          'isPhysicalDevice': androidInfo.isPhysicalDevice,
        });
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceInfo.addAll({
          'platform': 'iOS',
          'osVersion': iosInfo.systemVersion,
          'model': iosInfo.model,
          'name': iosInfo.name,
          'systemName': iosInfo.systemName,
          'identifierForVendor': iosInfo.identifierForVendor,
          'isPhysicalDevice': iosInfo.isPhysicalDevice,
        });
      }

      return deviceInfo;
    } catch (e) {
      return {
        'platform': Platform.operatingSystem,
        'error': 'Could not retrieve device info: $e',
      };
    }
  }

  static String generateBrowserInfo(Map<String, dynamic> deviceInfo) {
    if (deviceInfo['platform'] == 'Android') {
      return 'Mobile App Android ${deviceInfo['osVersion']} - ${deviceInfo['manufacturer']} ${deviceInfo['model']}';
    } else if (deviceInfo['platform'] == 'iOS') {
      return 'Mobile App iOS ${deviceInfo['osVersion']} - ${deviceInfo['model']}';
    }
    return 'Mobile App ${deviceInfo['platform']}';
  }

  static String generateOperatingSystem(Map<String, dynamic> deviceInfo) {
    if (deviceInfo['platform'] == 'Android') {
      return 'Android ${deviceInfo['osVersion']} (SDK ${deviceInfo['sdkInt']})';
    } else if (deviceInfo['platform'] == 'iOS') {
      return '${deviceInfo['systemName']} ${deviceInfo['osVersion']}';
    }
    return deviceInfo['platform'] ?? 'Unknown';
  }
}

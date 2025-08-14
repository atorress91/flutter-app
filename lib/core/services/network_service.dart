import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkService {
  static final NetworkInfo _networkInfo = NetworkInfo();

  /// Obtiene la IP local del dispositivo (WiFi o datos móviles)
  static Future<String?> getLocalIpAddress() async {
    try {
      // Para WiFi
      final wifiIP = await _networkInfo.getWifiIP();
      if (wifiIP != null) {
        return wifiIP;
      }

      // Fallback: usar NetworkInterface de dart:io
      return await _getLocalIpFromInterfaces();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting local IP: $e');
      }
      return await _getLocalIpFromInterfaces();
    }
  }

  /// Obtiene información completa de la red
  static Future<Map<String, dynamic>> getNetworkInfo() async {
    try {
      final info = <String, dynamic>{};

      // IP WiFi
      final wifiIP = await _networkInfo.getWifiIP();
      if (wifiIP != null) info['wifiIP'] = wifiIP;

      // Nombre de la red WiFi
      final wifiName = await _networkInfo.getWifiName();
      if (wifiName != null) info['wifiName'] = wifiName;

      // BSSID de la red WiFi
      final wifiBSSID = await _networkInfo.getWifiBSSID();
      if (wifiBSSID != null) info['wifiBSSID'] = wifiBSSID;

      // Gateway de la red
      final wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
      if (wifiGatewayIP != null) info['wifiGateway'] = wifiGatewayIP;

      // Máscara de subred
      final wifiSubnet = await _networkInfo.getWifiSubmask();
      if (wifiSubnet != null) info['wifiSubnet'] = wifiSubnet;

      return info;
    } catch (e) {
      return {'error': 'Could not get network info: $e'};
    }
  }

  /// Fallback usando NetworkInterface
  static Future<String?> _getLocalIpFromInterfaces() async {
    try {
      for (final interface in await NetworkInterface.list()) {
        for (final addr in interface.addresses) {
          // Filtrar direcciones locales válidas
          if (!addr.isLoopback &&
              addr.type == InternetAddressType.IPv4 &&
              !addr.address.startsWith('169.254')) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting IP from interfaces: $e');
      }
    }
    return null;
  }
}

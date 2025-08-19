import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/models/api_response.dart';
import '../../../../core/data/request/request_user_auth.dart';
import '../../../../core/providers/auth_providers.dart';
import '../../../../core/services/platform/device_info_service.dart';
import '../../../../core/services/platform/network_service.dart';

abstract class LoginService {
  Future<ApiResponse<bool>> performLogin(String username, String password);
}

class LoginServiceImpl implements LoginService {
  final Ref _ref;

  LoginServiceImpl(this._ref);

  @override
  Future<ApiResponse<bool>> performLogin(
    String username,
    String password,
  ) async {
    try {
      final futures = await Future.wait([
        DeviceInfoService.getDeviceInfo(),
        NetworkService.getLocalIpAddress(),
      ]);

      final deviceInfo = futures[0] as Map<String, dynamic>;
      final ipAddress = futures[1] as String?;

      final browserInfo = DeviceInfoService.generateBrowserInfo(deviceInfo);
      final operatingSystem = DeviceInfoService.generateOperatingSystem(
        deviceInfo,
      );

      final notifier = _ref.read(authNotifierProvider.notifier);
      final session = await notifier.login(
        RequestUserAuth(
          userName: username.trim(),
          password: password,
          browserInfo: browserInfo,
          ipAddress: ipAddress,
          operatingSystem: operatingSystem,
        ),
      );

      final authState = _ref.read(authNotifierProvider);
      if (authState.hasError) {
        return ApiResponse<bool>(
          success: false,
          data: false,
          message: authState.error.toString(),
          statusCode: 401, // Unauthorized
        );
      }

      final isAffiliate = session.user.isAffiliate;

      return ApiResponse<bool>(
        success: true,
        data: isAffiliate,
        message: null,
        statusCode: 200,
      );
    } catch (e) {
      return ApiResponse<bool>(
        success: false,
        data: false,
        message: e.toString(),
        statusCode: null,
      );
    }
  }
}

final loginServiceProvider = Provider<LoginService>(
  (ref) => LoginServiceImpl(ref),
);

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

const _kBiometricsEnabledKey = 'biometrics_enabled_v1';
const _kLastIsAffiliateKey = 'biometrics_last_is_affiliate_v1';

class BiometricService {
  final LocalAuthentication _auth;
  final FlutterSecureStorage _storage;

  BiometricService(this._auth, this._storage);

  Future<bool> isBiometricAvailable() async {
    try {
      final isSupported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      final types = await _auth.getAvailableBiometrics();
      return isSupported && canCheck && types.isNotEmpty;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> authenticate({
    String reason = 'Autentícate con tu huella',
  }) async {
    try {
      final didAuth = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      return didAuth;
    } on PlatformException {
      return false;
    }
  }

  Future<void> setEnabled(bool value) async {
    await _storage.write(key: _kBiometricsEnabledKey, value: value ? '1' : '0');
  }

  Future<bool> isEnabled() async {
    final v = await _storage.read(key: _kBiometricsEnabledKey);
    return v == '1';
  }

  Future<void> saveLastIsAffiliate(bool isAffiliate) async {
    await _storage.write(
      key: _kLastIsAffiliateKey,
      value: isAffiliate ? '1' : '0',
    );
  }

  Future<bool?> getLastIsAffiliate() async {
    final v = await _storage.read(key: _kLastIsAffiliateKey);
    if (v == null) return null;
    return v == '1';
  }
}

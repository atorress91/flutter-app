import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

const _kBiometricsEnabledKey = 'biometrics_enabled_v1';
const _kLastIsAffiliateKey = 'biometrics_last_is_affiliate_v1';
const _kBiometricUsernameKey = 'biometric_username_v1';
const _kBiometricPasswordKey = 'biometric_password_v1';

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

  /// Guarda las credenciales del usuario para login biométrico
  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: _kBiometricUsernameKey, value: username);
    await _storage.write(key: _kBiometricPasswordKey, value: password);
  }

  /// Recupera las credenciales guardadas
  Future<Map<String, String>?> getCredentials() async {
    final username = await _storage.read(key: _kBiometricUsernameKey);
    final password = await _storage.read(key: _kBiometricPasswordKey);

    if (username == null || password == null) return null;

    return {
      'username': username,
      'password': password,
    };
  }

  /// Elimina las credenciales guardadas
  Future<void> clearCredentials() async {
    await _storage.delete(key: _kBiometricUsernameKey);
    await _storage.delete(key: _kBiometricPasswordKey);
    await _storage.delete(key: _kLastIsAffiliateKey);
    await _storage.delete(key: _kBiometricsEnabledKey);
  }
}

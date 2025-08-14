import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/models/session_model.dart';
import '../data/dtos/users_affiliates_dto.dart';
import '../data/request/request_user_auth.dart';
import '../services/auth_service.dart';

const _kSessionKey = 'user_session_v1';

/// Storage seguro
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

/// Servicio HTTP
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService('https://tu-base-url/api/v1'), // <-- Ajusta tu base URL
);

/// Estado de autenticación (sin token)
class AuthNotifier extends AsyncNotifier<SessionModel?> {
  FlutterSecureStorage get _storage => ref.read(secureStorageProvider);

  AuthService get _service => ref.read(authServiceProvider);

  @override
  Future<SessionModel?> build() async {
    // Carga sesión persistida al iniciar la app
    final raw = await _storage.read(key: _kSessionKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return SessionModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  bool get isLoggedIn => state.value != null;

  UsersAffiliatesDto? get currentUser => state.value?.user;

  Future<void> login(RequestUserAuth req) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final data = await _service.login(req);

      // data puede ser "user" o "affiliate". Tomamos el primero que exista.
      final userPayload =
          (data['affiliate'] ?? data['user'] ?? data) as Map<String, dynamic>;

      final user = UsersAffiliatesDto.fromJson(userPayload);
      final session = SessionModel(user: user, loggedAt: DateTime.now());

      await _storage.write(
        key: _kSessionKey,
        value: jsonEncode(session.toJson()),
      );
      return session;
    });
  }

  Future<void> logout() async {
    await _storage.delete(key: _kSessionKey);
    state = const AsyncData(null);
  }

  Future<void> reloadFromStorage() async {
    final raw = await _storage.read(key: _kSessionKey);
    if (raw == null) {
      state = const AsyncData(null);
      return;
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      state = AsyncData(SessionModel.fromJson(map));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, SessionModel?>(
  () => AuthNotifier(),
);

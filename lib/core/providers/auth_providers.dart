import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/models/session_model.dart';
import '../data/dtos/users_affiliates_dto.dart';
import '../data/request/request_user_auth.dart';
import '../errors/exceptions.dart';
import '../services/auth_service.dart';

const _kSessionKey = 'user_session_v1';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Estado de autenticación
class AuthNotifier extends AsyncNotifier<SessionModel?> {
  FlutterSecureStorage get _storage => ref.read(secureStorageProvider);

  AuthService get _service => ref.read(authServiceProvider);

  @override
  Future<SessionModel?> build() async {
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

  Future<SessionModel> login(RequestUserAuth req) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final apiResponse = await _service.login(req);

      if (!apiResponse.success) {
        throw ApiException(apiResponse.message ?? 'Login fallido');
      }

      final data = apiResponse.data;
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

    state = result;
    return result.value!;
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

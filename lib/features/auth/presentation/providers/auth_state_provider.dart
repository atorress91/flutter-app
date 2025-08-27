import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/core/data/models/session_model.dart';
import 'package:my_app/core/data/request/request_user_auth.dart';
import 'package:my_app/core/data/request/request_user_registration.dart';
import 'package:my_app/features/auth/domain/entities/user.dart';
import 'package:my_app/features/auth/domain/repositories/auth_repository.dart';

import '../../data/providers/auth_providers.dart';

const _kSessionKey = 'user_session_v1';

class AuthNotifier extends AsyncNotifier<SessionModel?> {
  FlutterSecureStorage get _storage => ref.read(secureStorageProvider);

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  Future<SessionModel?> build() async {
    final raw = await _storage.read(key: _kSessionKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return SessionModel.fromJson(map);
    } catch (_) {
      await _storage.delete(key: _kSessionKey);
      return null;
    }
  }

  bool get isLoggedIn => state.value != null;

  User? get currentUser => state.value?.user;

  Future<SessionModel> login(RequestUserAuth req) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user = await _repository.login(req);
      final session = SessionModel(user: user, loggedAt: DateTime.now());

      await ref
          .read(secureStorageProvider)
          .write(key: _kSessionKey, value: jsonEncode(session.toJson()));
      return session;
    });

    state = result;
    if (result.hasError) throw result.error!;
    return result.value!;
  }

  Future<SessionModel> register(RequestUserRegistration req) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user = await _repository.register(req);
      final session = SessionModel(user: user, loggedAt: DateTime.now());

      await ref
          .read(secureStorageProvider)
          .write(key: _kSessionKey, value: jsonEncode(session.toJson()));
      return session;
    });

    state = result;
    if (result.hasError) throw result.error!;
    return result.value!;
  }

  Future<void> logout() async {
    await _repository.logout();
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

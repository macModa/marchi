import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';
import '../models/register_request.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<AuthResponse?>>((ref) {
  return AuthNotifier(
    ref.watch(authServiceProvider),
    ref.watch(secureStorageProvider),
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<AuthResponse?>> {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  AuthNotifier(this._authService, this._secureStorage) : super(const AsyncValue.data(null)) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    try {
      final token = await _secureStorage.getToken();
      final userId = await _secureStorage.getUserId();
      final email = await _secureStorage.getUserEmail();
      final role = await _secureStorage.getUserRole();

      if (token != null && userId != null && email != null && role != null) {
        state = AsyncValue.data(AuthResponse(
          token: token,
          type: 'Bearer',
          userId: userId,
          email: email,
          role: role,
        ));
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> login(AuthRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authService.login(request);
      if (response.success && response.data != null) {
        final authData = response.data!;
        await _secureStorage.saveUserSession(
          token: authData.token,
          userId: authData.userId,
          email: authData.email,
          role: authData.role,
        );
        state = AsyncValue.data(authData);
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> register(RegisterRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authService.register(request);
      if (response.success && response.data != null) {
        final authData = response.data!;
        await _secureStorage.saveUserSession(
          token: authData.token,
          userId: authData.userId,
          email: authData.email,
          role: authData.role,
        );
        state = AsyncValue.data(authData);
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAll();
    state = const AsyncValue.data(null);
  }
}

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).maybeWhen(
    data: (auth) => auth != null,
    orElse: () => false,
  );
});

final userRoleProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).maybeWhen(
    data: (auth) => auth?.role,
    orElse: () => null,
  );
});

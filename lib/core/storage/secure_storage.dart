import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Token Management
  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.keyAuthToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.keyAuthToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.keyAuthToken);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // User Data Management
  Future<void> saveUserId(int userId) async {
    await _storage.write(key: AppConstants.keyUserId, value: userId.toString());
  }

  Future<int?> getUserId() async {
    final value = await _storage.read(key: AppConstants.keyUserId);
    return value != null ? int.tryParse(value) : null;
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: AppConstants.keyUserEmail, value: email);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: AppConstants.keyUserEmail);
  }

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: AppConstants.keyUserRole, value: role);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: AppConstants.keyUserRole);
  }

  Future<void> saveUserName(String name) async {
    await _storage.write(key: AppConstants.keyUserName, value: name);
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: AppConstants.keyUserName);
  }

  // Clear All Data (Logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Save Complete User Session
  Future<void> saveUserSession({
    required String token,
    required int userId,
    required String email,
    required String role,
    String? name,
  }) async {
    await saveToken(token);
    await saveUserId(userId);
    await saveUserEmail(email);
    await saveUserRole(role);
    if (name != null) {
      await saveUserName(name);
    }
  }
}

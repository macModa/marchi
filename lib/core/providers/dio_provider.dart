import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/dio_client.dart';
import '../storage/secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final dioClientProvider = Provider<DioClient>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return DioClient(secureStorage);
});

final dioProvider = Provider((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.dio;
});



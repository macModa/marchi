import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/delivery_service.dart';

final deliveryServiceProvider = Provider((ref) => DeliveryService());

final deliveryNoteProvider = FutureProvider.family<Uint8List, int>((ref, orderId) async {
  return ref.read(deliveryServiceProvider).getDeliveryNote(orderId);
});

final deliveryValidationProvider = StateNotifierProvider<DeliveryValidationNotifier, AsyncValue<bool>>((ref) {
  return DeliveryValidationNotifier(ref.read(deliveryServiceProvider));
});

class DeliveryValidationNotifier extends StateNotifier<AsyncValue<bool>> {
  final DeliveryService _service;

  DeliveryValidationNotifier(this._service) : super(const AsyncValue.data(false));

  Future<void> validate(int orderId, String token) async {
    state = const AsyncValue.loading();
    try {
      final success = await _service.validateDelivery(orderId, token);
      state = AsyncValue.data(success);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

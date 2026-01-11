import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/dio_provider.dart';
import '../../../core/error/app_exception.dart';
import '../services/payment_service.dart';
import '../models/create_payment_request.dart';
import '../models/payment_dto.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  final dio = ref.watch(dioProvider);
  return PaymentService(dio);
});

// Payment State
class PaymentState {
  final PaymentDto? payment;
  final bool isLoading;
  final String? error;

  PaymentState({
    this.payment,
    this.isLoading = false,
    this.error,
  });

  PaymentState copyWith({
    PaymentDto? payment,
    bool? isLoading,
    String? error,
  }) {
    return PaymentState(
      payment: payment ?? this.payment,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentService _paymentService;

  PaymentNotifier(this._paymentService) : super(PaymentState());

  Future<PaymentDto?> createPayment(int orderId, CreatePaymentRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payment = await _paymentService.createPayment(orderId, request);
      state = state.copyWith(isLoading: false, payment: payment);
      return payment;
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return null;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Une erreur est survenue');
      return null;
    }
  }

  Future<void> loadPaymentByOrder(int orderId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payment = await _paymentService.getPaymentByOrder(orderId);
      state = state.copyWith(isLoading: false, payment: payment);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Une erreur est survenue');
    }
  }
}

final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  final paymentService = ref.watch(paymentServiceProvider);
  return PaymentNotifier(paymentService);
});


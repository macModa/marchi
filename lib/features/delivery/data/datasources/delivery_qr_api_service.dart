// lib/features/delivery/data/datasources/delivery_qr_api_service.dart

import '../../../../core/network/dio_client.dart';
import '../models/delivery_qr_models.dart';

class DeliveryQrApiService {
  final DioClient _dioClient = DioClient();

  Future<DeliveryQrResponse> generateQr(String trackingNumber) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      '/api/v1/delivery/qr/generate/$trackingNumber',
    );
    return DeliveryQrResponse.fromJson(response.data!);
  }

  Future<QrDeliveryConfirmationResponse> confirmDelivery(
      QrDeliveryConfirmationRequest request) async {
    final response = await _dioClient.post<dynamic>(
      '/api/v1/delivery/qr/confirm',
      data: request.toJson(),
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return QrDeliveryConfirmationResponse.fromJson(body);
    }

    // Réponse texte brut ou null = succès sans body JSON
    return QrDeliveryConfirmationResponse(
      success: true,
      trackingNumber: request.trackingNumber,
      newStatus: 'DELIVERED',
      deliveredAt: DateTime.now().toIso8601String(),
      message: 'Livraison confirmée',
    );
  }

  Future<DeliveryQrResponse> regenerateQr(String trackingNumber) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      '/api/v1/delivery/qr/regenerate/$trackingNumber',
    );
    return DeliveryQrResponse.fromJson(response.data!);
  }
}

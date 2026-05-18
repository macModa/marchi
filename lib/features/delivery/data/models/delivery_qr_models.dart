// lib/features/delivery/data/models/delivery_qr_models.dart

class DeliveryQrResponse {
  final String trackingNumber;
  final String qrCodeBase64;
  final String qrToken;
  final String expiresAt;

  DeliveryQrResponse({
    required this.trackingNumber,
    required this.qrCodeBase64,
    required this.qrToken,
    required this.expiresAt,
  });

  factory DeliveryQrResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryQrResponse(
        trackingNumber: json['trackingNumber'] as String? ?? '',
        qrCodeBase64: json['qrCodeBase64'] as String? ?? '',
        qrToken: json['qrToken'] as String? ?? '',
        expiresAt: json['expiresAt'] as String? ?? '',
      );
}

class QrDeliveryConfirmationRequest {
  final String trackingNumber;
  final String qrToken;
  final String? deliveryNotes;
  final String? gpsLocation;
  final String? deviceId;

  QrDeliveryConfirmationRequest({
    required this.trackingNumber,
    required this.qrToken,
    this.deliveryNotes,
    this.gpsLocation,
    this.deviceId,
  });

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'qrToken': qrToken,
        if (deliveryNotes != null) 'deliveryNotes': deliveryNotes,
        if (gpsLocation != null) 'gpsLocation': gpsLocation,
        if (deviceId != null) 'deviceId': deviceId,
      };
}

class QrDeliveryConfirmationResponse {
  final bool success;
  final String trackingNumber;
  final String newStatus;
  final String deliveredAt;
  final String message;

  QrDeliveryConfirmationResponse({
    required this.success,
    required this.trackingNumber,
    required this.newStatus,
    required this.deliveredAt,
    required this.message,
  });

  factory QrDeliveryConfirmationResponse.fromJson(Map<String, dynamic> json) =>
      QrDeliveryConfirmationResponse(
        success: json['success'] as bool? ?? true,
        trackingNumber: json['trackingNumber'] as String? ?? '',
        newStatus: json['newStatus'] as String? ?? 'DELIVERED',
        deliveredAt: json['deliveredAt'] as String? ?? '',
        message: json['message'] as String? ?? 'Livraison confirmée',
      );
}

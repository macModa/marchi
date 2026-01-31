import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
  @JsonValue('COMPLETED')
  completed('COMPLETED'),
  @JsonValue('FAILED')
  failed('FAILED'),
  @JsonValue('REFUNDED')
  refunded('REFUNDED');

  final String value;
  const PaymentStatus(this.value);

  static PaymentStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
      case 'EN_ATTENTE':
        return PaymentStatus.pending;
      case 'COMPLETED':
      case 'COMPLETE':
        return PaymentStatus.completed;
      case 'FAILED':
      case 'ECHOUE':
        return PaymentStatus.failed;
      case 'REFUNDED':
      case 'REMBOURSE':
        return PaymentStatus.refunded;
      default:
        throw ArgumentError('Invalid payment status: $status');
    }
  }

  String toJson() => value;
}

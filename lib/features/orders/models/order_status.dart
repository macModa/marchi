import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
  @JsonValue('CONFIRMED')
  confirmed('CONFIRMED'),
  @JsonValue('PROCESSING')
  processing('PROCESSING'),
  @JsonValue('SHIPPED')
  shipped('SHIPPED'),
  @JsonValue('DELIVERED')
  delivered('DELIVERED'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED');

  final String value;
  const OrderStatus(this.value);

  static OrderStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
      case 'EN_ATTENTE':
        return OrderStatus.pending;
      case 'CONFIRMED':
      case 'CONFIRMEE':
        return OrderStatus.confirmed;
      case 'PROCESSING':
      case 'EN_COURS':
        return OrderStatus.processing;
      case 'SHIPPED':
      case 'EXPEDIEE':
        return OrderStatus.shipped;
      case 'DELIVERED':
      case 'LIVREE':
        return OrderStatus.delivered;
      case 'CANCELLED':
      case 'ANNULEE':
        return OrderStatus.cancelled;
      default:
        throw ArgumentError('Invalid order status: $status');
    }
  }

  String toJson() => value;
}

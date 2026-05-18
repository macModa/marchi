import 'package:json_annotation/json_annotation.dart';
import 'order_status.dart';
import 'order_line_dto.dart';
import '../../payments/models/payment_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  final int id;
  @JsonKey(fromJson: orderStatusFromString, toJson: orderStatusToString)
  final OrderStatus statut;
  @JsonKey(defaultValue: 0.0)
  final double total;
  final String dateCreation;
  final String dateModification;
  @JsonKey(defaultValue: 0)
  final int clientId;
  final String clientNom;
  final List<OrderLineDto> orderLines;
  final PaymentDto? payment;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? deliveryToken;
  final String? trackingNumber;

  OrderDto({
    required this.id,
    required this.statut,
    required this.total,
    required this.dateCreation,
    required this.dateModification,
    required this.clientId,
    required this.clientNom,
    required this.orderLines,
    this.payment,
    this.paymentMethod,
    this.paymentStatus,
    this.deliveryToken,
    this.trackingNumber,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}

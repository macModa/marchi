import 'package:json_annotation/json_annotation.dart';
import '../../payments/models/payment_method.dart';
import '../../payments/models/payment_status.dart';

part 'payment_dto.g.dart';

@JsonSerializable()
class PaymentDto {
  final int? id;
  final PaymentMethod methode;
  final PaymentStatus statut;
  final String? reference;
  final String? dateCreation;
  final String? dateModification;
  final int orderId;

  PaymentDto({
    this.id,
    required this.methode,
    required this.statut,
    this.reference,
    this.dateCreation,
    this.dateModification,
    required this.orderId,
  });

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);
}

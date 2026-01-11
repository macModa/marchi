import 'package:json_annotation/json_annotation.dart';
import 'payment_method.dart';

part 'create_payment_request.g.dart';

@JsonSerializable()
class CreatePaymentRequest {
  final PaymentMethod methode;
  final String? reference;

  CreatePaymentRequest({
    required this.methode,
    this.reference,
  });

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentRequestToJson(this);
}



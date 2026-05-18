// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentRequest _$CreatePaymentRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentRequest(
  methode: paymentMethodFromString(json['methode'] as String),
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$CreatePaymentRequestToJson(
  CreatePaymentRequest instance,
) => <String, dynamic>{
  'methode': paymentMethodToString(instance.methode),
  'reference': instance.reference,
};

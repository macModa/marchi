// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentRequest _$CreatePaymentRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentRequest(
  methode: $enumDecode(_$PaymentMethodEnumMap, json['methode']),
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$CreatePaymentRequestToJson(
  CreatePaymentRequest instance,
) => <String, dynamic>{
  'methode': instance.methode,
  'reference': instance.reference,
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.carte_bancaire: 'carte_bancaire',
  PaymentMethod.virement: 'virement',
  PaymentMethod.espece: 'espece',
};

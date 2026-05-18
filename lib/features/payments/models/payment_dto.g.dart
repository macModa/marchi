// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
  id: (json['id'] as num?)?.toInt(),
  montant: (json['montant'] as num?)?.toDouble(),
  methode: paymentMethodFromString(json['methode'] as String),
  statut: paymentStatusFromString(json['statut'] as String),
  reference: json['reference'] as String?,
  dateCreation: json['dateCreation'] as String?,
  dateModification: json['dateModification'] as String?,
  orderId: (json['orderId'] as num).toInt(),
);

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'montant': instance.montant,
      'methode': paymentMethodToString(instance.methode),
      'statut': paymentStatusToString(instance.statut),
      'reference': instance.reference,
      'dateCreation': instance.dateCreation,
      'dateModification': instance.dateModification,
      'orderId': instance.orderId,
    };

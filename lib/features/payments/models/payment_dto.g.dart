// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
  id: (json['id'] as num?)?.toInt(),
  methode: $enumDecode(_$PaymentMethodEnumMap, json['methode']),
  statut: $enumDecode(_$PaymentStatusEnumMap, json['statut']),
  reference: json['reference'] as String?,
  dateCreation: json['dateCreation'] as String?,
  dateModification: json['dateModification'] as String?,
  orderId: (json['orderId'] as num).toInt(),
);

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'methode': instance.methode,
      'statut': instance.statut,
      'reference': instance.reference,
      'dateCreation': instance.dateCreation,
      'dateModification': instance.dateModification,
      'orderId': instance.orderId,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'CASH',
  PaymentMethod.card: 'CARD',
  PaymentMethod.mobileMoney: 'MOBILE_MONEY',
  PaymentMethod.bankTransfer: 'BANK_TRANSFER',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'PENDING',
  PaymentStatus.completed: 'COMPLETED',
  PaymentStatus.failed: 'FAILED',
  PaymentStatus.refunded: 'REFUNDED',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
  id: (json['id'] as num?)?.toInt(),
  montant: (json['montant'] as num).toDouble(),
  methode: $enumDecode(_$PaymentMethodEnumMap, json['methode']),
  statut: $enumDecode(_$PaymentStatusEnumMap, json['statut']),
  reference: json['reference'] as String?,
  dateCreation: json['dateCreation'] as String?,
  orderId: (json['orderId'] as num).toInt(),
);

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'montant': instance.montant,
      'methode': instance.methode,
      'statut': instance.statut,
      'reference': instance.reference,
      'dateCreation': instance.dateCreation,
      'orderId': instance.orderId,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.carte_bancaire: 'carte_bancaire',
  PaymentMethod.virement: 'virement',
  PaymentMethod.espece: 'espece',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.en_attente: 'en_attente',
  PaymentStatus.complete: 'complete',
  PaymentStatus.echoue: 'echoue',
  PaymentStatus.rembourse: 'rembourse',
};

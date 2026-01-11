// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
  id: (json['id'] as num).toInt(),
  statut: $enumDecode(_$OrderStatusEnumMap, json['statut']),
  total: (json['total'] as num).toDouble(),
  dateCreation: json['dateCreation'] as String,
  dateModification: json['dateModification'] as String,
  clientId: (json['clientId'] as num).toInt(),
  clientNom: json['clientNom'] as String,
  orderLines: (json['orderLines'] as List<dynamic>)
      .map((e) => OrderLineDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  payment: json['payment'] == null
      ? null
      : PaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'statut': instance.statut,
  'total': instance.total,
  'dateCreation': instance.dateCreation,
  'dateModification': instance.dateModification,
  'clientId': instance.clientId,
  'clientNom': instance.clientNom,
  'orderLines': instance.orderLines,
  'payment': instance.payment,
};

const _$OrderStatusEnumMap = {
  OrderStatus.en_attente: 'en_attente',
  OrderStatus.confirmee: 'confirmee',
  OrderStatus.en_cours: 'en_cours',
  OrderStatus.expediee: 'expediee',
  OrderStatus.livree: 'livree',
  OrderStatus.annulee: 'annulee',
};

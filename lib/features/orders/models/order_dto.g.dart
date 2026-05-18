// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
  id: (json['id'] as num).toInt(),
  statut: orderStatusFromString(json['statut'] as String?),
  total: (json['total'] as num?)?.toDouble() ?? 0.0,
  dateCreation: json['dateCreation'] as String,
  dateModification: json['dateModification'] as String,
  clientId: (json['clientId'] as num?)?.toInt() ?? 0,
  clientNom: json['clientNom'] as String,
  orderLines: (json['orderLines'] as List<dynamic>)
      .map((e) => OrderLineDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  payment: json['payment'] == null
      ? null
      : PaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
  paymentMethod: json['paymentMethod'] as String?,
  paymentStatus: json['paymentStatus'] as String?,
  deliveryToken: json['deliveryToken'] as String?,
  trackingNumber: json['trackingNumber'] as String?,
);

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'statut': orderStatusToString(instance.statut),
  'total': instance.total,
  'dateCreation': instance.dateCreation,
  'dateModification': instance.dateModification,
  'clientId': instance.clientId,
  'clientNom': instance.clientNom,
  'orderLines': instance.orderLines,
  'payment': instance.payment,
  'paymentMethod': instance.paymentMethod,
  'paymentStatus': instance.paymentStatus,
  'deliveryToken': instance.deliveryToken,
  'trackingNumber': instance.trackingNumber,
};

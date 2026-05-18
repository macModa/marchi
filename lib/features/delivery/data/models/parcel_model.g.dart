// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParcelModelImpl _$$ParcelModelImplFromJson(Map<String, dynamic> json) =>
    _$ParcelModelImpl(
      id: (json['id'] as num?)?.toInt(),
      trackingNumber: json['trackingNumber'] as String,
      recipientName: json['recipientName'] as String,
      recipientPhone: json['recipientPhone'] as String,
      recipientAddress: json['recipientAddress'] as String?,
      status: json['status'] as String,
      relayPointId: (json['relayPointId'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      estimatedDeliveryDate: json['estimatedDeliveryDate'] == null
          ? null
          : DateTime.parse(json['estimatedDeliveryDate'] as String),
    );

Map<String, dynamic> _$$ParcelModelImplToJson(
  _$ParcelModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'trackingNumber': instance.trackingNumber,
  'recipientName': instance.recipientName,
  'recipientPhone': instance.recipientPhone,
  'recipientAddress': instance.recipientAddress,
  'status': instance.status,
  'relayPointId': instance.relayPointId,
  'weight': instance.weight,
  'price': instance.price,
  'createdAt': instance.createdAt?.toIso8601String(),
  'estimatedDeliveryDate': instance.estimatedDeliveryDate?.toIso8601String(),
};

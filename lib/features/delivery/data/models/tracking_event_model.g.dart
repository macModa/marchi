// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingEventModelImpl _$$TrackingEventModelImplFromJson(
  Map<String, dynamic> json,
) => _$TrackingEventModelImpl(
  id: (json['id'] as num?)?.toInt(),
  trackingNumber: json['trackingNumber'] as String,
  status: json['status'] as String,
  location: json['location'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$TrackingEventModelImplToJson(
  _$TrackingEventModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'trackingNumber': instance.trackingNumber,
  'status': instance.status,
  'location': instance.location,
  'timestamp': instance.timestamp.toIso8601String(),
  'description': instance.description,
};

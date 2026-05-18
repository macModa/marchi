// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relay_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelayPointModelImpl _$$RelayPointModelImplFromJson(
  Map<String, dynamic> json,
) => _$RelayPointModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String,
  postalCode: json['postalCode'] as String,
  city: json['city'] as String,
  governorate: json['governorate'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  openingHours: json['openingHours'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$$RelayPointModelImplToJson(
  _$RelayPointModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'postalCode': instance.postalCode,
  'city': instance.city,
  'governorate': instance.governorate,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'openingHours': instance.openingHours,
  'phone': instance.phone,
};

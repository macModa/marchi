// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  token: json['token'] as String,
  type: json['type'] as String,
  userId: (json['userId'] as num).toInt(),
  email: json['email'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'userId': instance.userId,
      'email': instance.email,
      'role': instance.role,
    };

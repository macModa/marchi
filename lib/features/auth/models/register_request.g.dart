// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      nom: json['nom'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      telephone: json['telephone'] as String?,
      ville: json['ville'] as String?,
      role: json['role'] as String,
      nomBoutique: json['nomBoutique'] as String?,
      description: json['description'] as String?,
      adresseLivraison: json['adresseLivraison'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'email': instance.email,
      'password': instance.password,
      'telephone': instance.telephone,
      'ville': instance.ville,
      'role': instance.role,
      'nomBoutique': instance.nomBoutique,
      'description': instance.description,
      'adresseLivraison': instance.adresseLivraison,
    };

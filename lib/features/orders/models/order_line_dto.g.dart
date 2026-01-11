// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_line_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLineDto _$OrderLineDtoFromJson(Map<String, dynamic> json) => OrderLineDto(
  id: (json['id'] as num?)?.toInt(),
  productId: (json['productId'] as num).toInt(),
  productNom: json['productNom'] as String?,
  quantite: (json['quantite'] as num).toInt(),
  prixUnitaire: (json['prixUnitaire'] as num?)?.toDouble(),
  sousTotal: (json['sousTotal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrderLineDtoToJson(OrderLineDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productNom': instance.productNom,
      'quantite': instance.quantite,
      'prixUnitaire': instance.prixUnitaire,
      'sousTotal': instance.sousTotal,
    };

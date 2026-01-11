// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
  id: (json['id'] as num?)?.toInt(),
  nom: json['nom'] as String,
  description: json['description'] as String?,
  prix: (json['prix'] as num).toDouble(),
  stock: (json['stock'] as num).toInt(),
  artisanId: (json['artisanId'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  artisanNom: json['artisanNom'] as String?,
  categoryNom: json['categoryNom'] as String?,
);

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'description': instance.description,
      'prix': instance.prix,
      'stock': instance.stock,
      'artisanId': instance.artisanId,
      'categoryId': instance.categoryId,
      'artisanNom': instance.artisanNom,
      'categoryNom': instance.categoryNom,
    };

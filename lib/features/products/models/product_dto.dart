import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final int? id;
  final String nom;
  final String? description;
  @JsonKey(defaultValue: 0.0)
  final double prix;
  @JsonKey(defaultValue: 0)
  final int stock;
  @JsonKey(defaultValue: 0)
  final int artisanId;
  @JsonKey(defaultValue: 0)
  final int categoryId;
  final String? artisanNom;
  final String? categoryNom;

  ProductDto({
    this.id,
    required this.nom,
    this.description,
    required this.prix,
    required this.stock,
    required this.artisanId,
    required this.categoryId,
    this.artisanNom,
    this.categoryNom,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

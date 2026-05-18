import 'package:json_annotation/json_annotation.dart';
import '../../categories/models/category_dto.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final int? id;
  final String nom;
  final String? description;
//   @JsonKey(defaultValue: 0.0)
  final double prix;
//   @JsonKey(defaultValue: 0)
  final int stock;
//   @JsonKey(defaultValue: 0)
  final int? artisanId;
//   @JsonKey(defaultValue: 0)
  final int? categoryId;
  final String? artisanNom;
  final String? categoryNom;
  final String? imageUrl;
  final CategoryDto? category;

  ProductDto({
    this.id,
    required this.nom,
    this.description,
    required this.prix,
    required this.stock,
    this.artisanId,
    this.categoryId,
    this.artisanNom,
    this.categoryNom,
    this.imageUrl,
    this.category,
  });

  ProductDto copyWith({
    int? id,
    String? nom,
    String? description,
    double? prix,
    int? stock,
    int? artisanId,
    int? categoryId,
    String? artisanNom,
    String? categoryNom,
    String? imageUrl,
  }) {
    return ProductDto(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      prix: prix ?? this.prix,
      stock: stock ?? this.stock,
      artisanId: artisanId ?? this.artisanId,
      categoryId: categoryId ?? this.categoryId,
      artisanNom: artisanNom ?? this.artisanNom,
      categoryNom: categoryNom ?? this.categoryNom,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

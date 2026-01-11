import 'package:json_annotation/json_annotation.dart';

part 'order_line_dto.g.dart';

@JsonSerializable()
class OrderLineDto {
  final int? id;
  final int productId;
  final String? productNom;
  final int quantite;
  final double? prixUnitaire;
  final double? sousTotal;

  OrderLineDto({
    this.id,
    required this.productId,
    this.productNom,
    required this.quantite,
    this.prixUnitaire,
    this.sousTotal,
  });

  factory OrderLineDto.fromJson(Map<String, dynamic> json) =>
      _$OrderLineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineDtoToJson(this);
}

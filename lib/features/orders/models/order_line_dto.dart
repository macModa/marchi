import 'package:json_annotation/json_annotation.dart';

part 'order_line_dto.g.dart';

@JsonSerializable()
class OrderLineDto {
  final int? id;
  @JsonKey(defaultValue: 0)
  final int productId;
  final String? productNom;
  @JsonKey(defaultValue: 0)
  final int quantite;
  @JsonKey(defaultValue: 0.0)
  final double? prixUnitaire;
  @JsonKey(defaultValue: 0.0)
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

import 'package:json_annotation/json_annotation.dart';

part 'create_order_request.g.dart';

@JsonSerializable()
class CreateOrderRequest {
  final List<OrderLineRequest> orderLines;

  CreateOrderRequest({
    required this.orderLines,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}

@JsonSerializable()
class OrderLineRequest {
  final int productId;
  final int quantite;

  OrderLineRequest({
    required this.productId,
    required this.quantite,
  });

  factory OrderLineRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderLineRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineRequestToJson(this);
}

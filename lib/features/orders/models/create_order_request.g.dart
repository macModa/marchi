// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(
      orderLines: (json['orderLines'] as List<dynamic>)
          .map((e) => OrderLineRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) =>
    <String, dynamic>{'orderLines': instance.orderLines};

OrderLineRequest _$OrderLineRequestFromJson(Map<String, dynamic> json) =>
    OrderLineRequest(
      productId: (json['productId'] as num).toInt(),
      quantite: (json['quantite'] as num).toInt(),
    );

Map<String, dynamic> _$OrderLineRequestToJson(OrderLineRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantite': instance.quantite,
    };

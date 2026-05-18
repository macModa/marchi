import 'package:equatable/equatable.dart';

class Parcel extends Equatable {
  final int? id;
  final String trackingNumber;
  final String recipientName;
  final String recipientPhone;
  final String? recipientAddress;
  final String status;
  final int? relayPointId;
  final double? weight;
  final double? price;
  final DateTime? createdAt;
  final DateTime? estimatedDeliveryDate;

  const Parcel({
    this.id,
    required this.trackingNumber,
    required this.recipientName,
    required this.recipientPhone,
    this.recipientAddress,
    required this.status,
    this.relayPointId,
    this.weight,
    this.price,
    this.createdAt,
    this.estimatedDeliveryDate,
  });

  @override
  List<Object?> get props => [
    id,
    trackingNumber,
    recipientName,
    recipientPhone,
    recipientAddress,
    status,
    relayPointId,
    weight,
    price,
    createdAt,
    estimatedDeliveryDate,
  ];
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/parcel.dart';

part 'parcel_model.freezed.dart';
part 'parcel_model.g.dart';

@freezed
class ParcelModel with _$ParcelModel {
  const ParcelModel._();

  const factory ParcelModel({
    int? id,
    required String trackingNumber,
    required String recipientName,
    required String recipientPhone,
    String? recipientAddress,
    required String status,
    int? relayPointId,
    double? weight,
    double? price,
    DateTime? createdAt,
    DateTime? estimatedDeliveryDate,
  }) = _ParcelModel;

  factory ParcelModel.fromJson(Map<String, dynamic> json) =>
      _$ParcelModelFromJson(json);

  /// Maps the Data Model to the Domain Entity
  Parcel toEntity() {
    return Parcel(
      id: id,
      trackingNumber: trackingNumber,
      recipientName: recipientName,
      recipientPhone: recipientPhone,
      recipientAddress: recipientAddress,
      status: status,
      relayPointId: relayPointId,
      weight: weight,
      price: price,
      createdAt: createdAt,
      estimatedDeliveryDate: estimatedDeliveryDate,
    );
  }
}

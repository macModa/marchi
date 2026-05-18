import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/relay_point.dart';

part 'relay_point_model.freezed.dart';
part 'relay_point_model.g.dart';

@freezed
class RelayPointModel with _$RelayPointModel {
  const RelayPointModel._();

  const factory RelayPointModel({
    required int id,
    required String name,
    required String address,
    required String postalCode,
    required String city,
    required String governorate,
    required double latitude,
    required double longitude,
    String? openingHours,
    String? phone,
  }) = _RelayPointModel;

  factory RelayPointModel.fromJson(Map<String, dynamic> json) =>
      _$RelayPointModelFromJson(json);

  /// Maps the Data Model to the Domain Entity
  RelayPoint toEntity() {
    return RelayPoint(
      id: id,
      name: name,
      address: address,
      postalCode: postalCode,
      city: city,
      governorate: governorate,
      latitude: latitude,
      longitude: longitude,
      openingHours: openingHours,
      phone: phone,
    );
  }
}

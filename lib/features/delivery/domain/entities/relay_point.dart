import 'package:equatable/equatable.dart';

class RelayPoint extends Equatable {
  final int id;
  final String name;
  final String address;
  final String postalCode;
  final String city;
  final String governorate;
  final double latitude;
  final double longitude;
  final String? openingHours;
  final String? phone;

  const RelayPoint({
    required this.id,
    required this.name,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.governorate,
    required this.latitude,
    required this.longitude,
    this.openingHours,
    this.phone,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    postalCode,
    city,
    governorate,
    latitude,
    longitude,
    openingHours,
    phone,
  ];
}

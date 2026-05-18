import 'package:equatable/equatable.dart';

class TrackingEvent extends Equatable {
  final int? id;
  final String trackingNumber;
  final String status;
  final String? location;
  final DateTime timestamp;
  final String? description;

  const TrackingEvent({
    this.id,
    required this.trackingNumber,
    required this.status,
    this.location,
    required this.timestamp,
    this.description,
  });

  @override
  List<Object?> get props => [
    id,
    trackingNumber,
    status,
    location,
    timestamp,
    description,
  ];
}

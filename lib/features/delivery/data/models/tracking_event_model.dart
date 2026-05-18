import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/tracking_event.dart';

part 'tracking_event_model.freezed.dart';
part 'tracking_event_model.g.dart';

@freezed
class TrackingEventModel with _$TrackingEventModel {
  const TrackingEventModel._();

  const factory TrackingEventModel({
    int? id,
    required String trackingNumber,
    required String status,
    String? location,
    required DateTime timestamp,
    String? description,
  }) = _TrackingEventModel;

  factory TrackingEventModel.fromJson(Map<String, dynamic> json) =>
      _$TrackingEventModelFromJson(json);

  /// Maps the Data Model to the Domain Entity
  TrackingEvent toEntity() {
    return TrackingEvent(
      id: id,
      trackingNumber: trackingNumber,
      status: status,
      location: location,
      timestamp: timestamp,
      description: description,
    );
  }
}

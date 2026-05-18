import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/parcel.dart';
import '../entities/relay_point.dart';
import '../entities/tracking_event.dart';

abstract class DeliveryRepository {
  /// Fetches a parcel by its tracking number
  Future<Either<Failure, Parcel>> getParcelByTracking(String trackingNumber);

  /// Fetches a list of tracking events for a given parcel
  Future<Either<Failure, List<TrackingEvent>>> getTrackingTimeline(
    String trackingNumber,
  );

  /// Fetches relay points by postal code
  Future<Either<Failure, List<RelayPoint>>> getRelaysByPostalCode(
    String postalCode,
  );

  /// Updates the status of a parcel
  Future<Either<Failure, Unit>> updateParcelStatus(
    String trackingNumber,
    String status,
  );

  /// Creates a new parcel
  Future<Either<Failure, Parcel>> createParcel(Parcel parcel);
}

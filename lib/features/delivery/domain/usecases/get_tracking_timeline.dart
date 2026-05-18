import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/tracking_event.dart';
import '../repositories/delivery_repository.dart';

class GetTrackingTimeline {
  final DeliveryRepository repository;

  GetTrackingTimeline(this.repository);

  Future<Either<Failure, List<TrackingEvent>>> call(String trackingNumber) {
    return repository.getTrackingTimeline(trackingNumber);
  }
}

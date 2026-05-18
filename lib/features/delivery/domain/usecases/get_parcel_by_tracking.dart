import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/parcel.dart';
import '../repositories/delivery_repository.dart';

class GetParcelByTracking {
  final DeliveryRepository repository;

  GetParcelByTracking(this.repository);

  Future<Either<Failure, Parcel>> call(String trackingNumber) {
    return repository.getParcelByTracking(trackingNumber);
  }
}

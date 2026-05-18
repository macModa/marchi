import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../repositories/delivery_repository.dart';

class UpdateParcelStatus {
  final DeliveryRepository repository;

  UpdateParcelStatus(this.repository);

  Future<Either<Failure, Unit>> call(String trackingNumber, String status) {
    return repository.updateParcelStatus(trackingNumber, status);
  }
}

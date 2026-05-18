import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/relay_point.dart';
import '../repositories/delivery_repository.dart';

class GetRelaysByPostalCode {
  final DeliveryRepository repository;

  GetRelaysByPostalCode(this.repository);

  Future<Either<Failure, List<RelayPoint>>> call(String postalCode) {
    return repository.getRelaysByPostalCode(postalCode);
  }
}

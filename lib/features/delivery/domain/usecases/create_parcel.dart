import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/parcel.dart';
import '../repositories/delivery_repository.dart';

class CreateParcel {
  final DeliveryRepository repository;

  CreateParcel(this.repository);

  Future<Either<Failure, Parcel>> call(Parcel parcel) {
    return repository.createParcel(parcel);
  }
}

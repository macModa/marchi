import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/bon_livraison_entity.dart';
import '../repositories/bon_livraison_repository.dart';

class GetBonLivraison {
  final BonLivraisonRepository _repository;

  const GetBonLivraison(this._repository);

  Future<Either<Failure, BonLivraisonEntity>> call(int orderId) =>
      _repository.getBonLivraison(orderId);
}

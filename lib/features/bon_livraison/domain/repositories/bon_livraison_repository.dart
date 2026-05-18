import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/bon_livraison_entity.dart';

abstract class BonLivraisonRepository {
  Future<Either<Failure, BonLivraisonEntity>> getBonLivraison(int orderId);
}

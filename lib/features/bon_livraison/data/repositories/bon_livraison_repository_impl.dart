import 'package:fpdart/fpdart.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/bon_livraison_entity.dart';
import '../../domain/repositories/bon_livraison_repository.dart';
import '../datasources/bon_livraison_remote_data_source.dart';

class BonLivraisonRepositoryImpl implements BonLivraisonRepository {
  final BonLivraisonRemoteDataSource _remoteDataSource;

  const BonLivraisonRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, BonLivraisonEntity>> getBonLivraison(
      int orderId) async {
    try {
      final model = await _remoteDataSource.getBonLivraison(orderId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(_mapToFailure(e));
    }
  }

  Failure _mapToFailure(Object e) {
    final appException = ErrorHandler.handleException(e);
    if (appException is ServerException) {
      return ServerFailure(appException.message,
          code: appException.code, details: appException.details);
    } else if (appException is NetworkException ||
        appException is TimeoutException) {
      return NetworkFailure(appException.message,
          code: appException.code, details: appException.details);
    } else if (appException is AuthException ||
        appException is UnauthorizedException) {
      return AuthFailure(appException.message,
          code: appException.code, details: appException.details);
    } else if (appException is NotFoundException) {
      return NotFoundFailure(appException.message,
          code: appException.code, details: appException.details);
    }
    return UnknownFailure(appException.message,
        code: appException.code, details: appException.details);
  }
}

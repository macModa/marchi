import 'package:fpdart/fpdart.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/parcel.dart';
import '../../domain/entities/relay_point.dart';
import '../../domain/entities/tracking_event.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../datasources/delivery_remote_data_source.dart';
import '../models/parcel_model.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final DeliveryRemoteDataSource remoteDataSource;

  DeliveryRepositoryImpl(this.remoteDataSource);

  Failure _mapExceptionToFailure(Object e) {
    final appException = ErrorHandler.handleException(e);

    if (appException is ServerException) {
      return ServerFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    } else if (appException is NetworkException ||
        appException is TimeoutException) {
      return NetworkFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    } else if (appException is AuthException ||
        appException is UnauthorizedException) {
      return AuthFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    } else if (appException is ValidationException) {
      return ValidationFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    } else if (appException is NotFoundException) {
      return NotFoundFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    } else {
      return UnknownFailure(
        appException.message,
        code: appException.code,
        details: appException.details,
      );
    }
  }

  @override
  Future<Either<Failure, Parcel>> getParcelByTracking(
    String trackingNumber,
  ) async {
    try {
      final model = await remoteDataSource.getParcelByTracking(trackingNumber);
      return Right(model.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TrackingEvent>>> getTrackingTimeline(
    String trackingNumber,
  ) async {
    try {
      final models = await remoteDataSource.getTrackingTimeline(trackingNumber);
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<RelayPoint>>> getRelaysByPostalCode(
    String postalCode,
  ) async {
    try {
      final models = await remoteDataSource.getRelaysByPostalCode(postalCode);
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateParcelStatus(
    String trackingNumber,
    String status,
  ) async {
    try {
      await remoteDataSource.updateParcelStatus(trackingNumber, status);
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Parcel>> createParcel(Parcel parcel) async {
    try {
      final model = ParcelModel(
        trackingNumber: parcel.trackingNumber,
        recipientName: parcel.recipientName,
        recipientPhone: parcel.recipientPhone,
        recipientAddress: parcel.recipientAddress,
        status: parcel.status,
        relayPointId: parcel.relayPointId,
        weight: parcel.weight,
        price: parcel.price,
      );
      final createdModel = await remoteDataSource.createParcel(model);
      return Right(createdModel.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/delivery_remote_data_source.dart';
import '../../data/repositories/delivery_repository_impl.dart';
import '../../domain/entities/parcel.dart';
import '../../domain/entities/relay_point.dart';
import '../../domain/entities/tracking_event.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../../domain/usecases/get_parcel_by_tracking.dart';
import '../../domain/usecases/get_relays_by_postal_code.dart';
import '../../domain/usecases/get_tracking_timeline.dart';

part 'delivery_providers.g.dart';

@riverpod
DeliveryRemoteDataSource deliveryRemoteDataSource(
  DeliveryRemoteDataSourceRef ref,
) {
  return DeliveryRemoteDataSourceImpl(DioClient());
}

@riverpod
DeliveryRepository deliveryRepository(DeliveryRepositoryRef ref) {
  final dataSource = ref.watch(deliveryRemoteDataSourceProvider);
  return DeliveryRepositoryImpl(dataSource);
}

@riverpod
GetParcelByTracking getParcelByTrackingUseCase(
  GetParcelByTrackingUseCaseRef ref,
) {
  final repository = ref.watch(deliveryRepositoryProvider);
  return GetParcelByTracking(repository);
}

@riverpod
GetRelaysByPostalCode getRelaysByPostalCodeUseCase(
  GetRelaysByPostalCodeUseCaseRef ref,
) {
  final repository = ref.watch(deliveryRepositoryProvider);
  return GetRelaysByPostalCode(repository);
}

@riverpod
GetTrackingTimeline getTrackingTimelineUseCase(
  GetTrackingTimelineUseCaseRef ref,
) {
  final repository = ref.watch(deliveryRepositoryProvider);
  return GetTrackingTimeline(repository);
}

@riverpod
Future<Either<Failure, Parcel>> parcelByTracking(
  ParcelByTrackingRef ref,
  String trackingNumber,
) {
  final usecase = ref.watch(getParcelByTrackingUseCaseProvider);
  return usecase(trackingNumber);
}

@riverpod
Future<Either<Failure, List<RelayPoint>>> relaysByPostalCode(
  RelaysByPostalCodeRef ref,
  String postalCode,
) {
  final usecase = ref.watch(getRelaysByPostalCodeUseCaseProvider);
  return usecase(postalCode);
}

@riverpod
Future<Either<Failure, List<TrackingEvent>>> trackingTimeline(
  TrackingTimelineRef ref,
  String trackingNumber,
) {
  final usecase = ref.watch(getTrackingTimelineUseCaseProvider);
  return usecase(trackingNumber);
}

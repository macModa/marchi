import '../../../../core/network/dio_client.dart';
import '../models/parcel_model.dart';
import '../models/relay_point_model.dart';
import '../models/tracking_event_model.dart';
import '../../../../core/error/app_exception.dart';

abstract class DeliveryRemoteDataSource {
  Future<ParcelModel> getParcelByTracking(String trackingNumber);
  Future<List<TrackingEventModel>> getTrackingTimeline(String trackingNumber);
  Future<List<RelayPointModel>> getRelaysByPostalCode(String postalCode);
  Future<void> updateParcelStatus(String trackingNumber, String status);
  Future<ParcelModel> createParcel(ParcelModel parcel);
}

class DeliveryRemoteDataSourceImpl implements DeliveryRemoteDataSource {
  final DioClient _client;

  DeliveryRemoteDataSourceImpl(this._client);

  @override
  Future<ParcelModel> getParcelByTracking(String trackingNumber) async {
    final response = await _client.get('/api/delivery/parcels/$trackingNumber');
    if (response.data is Map<String, dynamic>) {
      return ParcelModel.fromJson(response.data);
    } else {
      throw ServerException(
        response.data?.toString() ?? 'Invalid response format',
        code: response.statusCode?.toString(),
      );
    }
  }

  @override
  Future<List<TrackingEventModel>> getTrackingTimeline(
    String trackingNumber,
  ) async {
    final response = await _client.get(
      '/api/delivery/tracking/$trackingNumber',
    );
    if (response.data is List) {
      return (response.data as List)
          .map((json) => TrackingEventModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
        response.data?.toString() ?? 'Invalid response format',
        code: response.statusCode?.toString(),
      );
    }
  }

  @override
  Future<List<RelayPointModel>> getRelaysByPostalCode(String postalCode) async {
    final response = await _client.get(
      '/api/delivery/relays',
      queryParameters: {'postalCode': postalCode},
    );
    if (response.data is List) {
      return (response.data as List)
          .map((json) => RelayPointModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
        response.data?.toString() ?? 'Invalid response format',
        code: response.statusCode?.toString(),
      );
    }
  }

  @override
  Future<void> updateParcelStatus(String trackingNumber, String status) async {
    await _client.put(
      '/api/delivery/parcels/$trackingNumber/status',
      data: {'status': status},
    );
  }

  @override
  Future<ParcelModel> createParcel(ParcelModel parcel) async {
    final response = await _client.post(
      '/api/delivery/parcels',
      data: parcel.toJson(),
    );
    if (response.data is Map<String, dynamic>) {
      return ParcelModel.fromJson(response.data);
    } else {
      throw ServerException(
        response.data?.toString() ?? 'Invalid response format',
        code: response.statusCode?.toString(),
      );
    }
  }
}

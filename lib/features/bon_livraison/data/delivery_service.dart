import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class DeliveryService {
  final Dio _dio = DioClient().dio;

  /// Récupère le PDF du bon de livraison pour l'artisan.
  Future<Uint8List> getDeliveryNote(int orderId) async {
    final response = await _dio.get(
      '/api/orders/$orderId/delivery-note',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data as List<int>);
  }

  /// Valide la livraison via le token (pour le client).
  Future<bool> validateDelivery(int orderId, String token) async {
    final response = await _dio.post(
      '/api/orders/$orderId/validate-delivery',
      queryParameters: {'token': token},
    );
    return response.statusCode == 200;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';

abstract class ConfirmDeliveryDataSource {
  Future<void> confirm(String trackingNumber);
}

class ConfirmDeliveryDataSourceImpl implements ConfirmDeliveryDataSource {
  ConfirmDeliveryDataSourceImpl(this._dio);
  final DioClient _dio;

  @override
  Future<void> confirm(String trackingNumber) async {
    await _dio.post(
      ApiConstants.confirmDeliveryByQr,
      data: {
        'trackingNumber': trackingNumber,
        'deliveryNotes': 'Livraison confirmée par scan QR',
      },
      // ✅ FIX: pas de ResponseType.plain — Dio gère JSON normalement
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}

class ConfirmDeliveryNotifier extends StateNotifier<AsyncValue<void>> {
  ConfirmDeliveryNotifier() : super(const AsyncData(null));

  Future<Either<Failure, void>> confirm(String qrContent) async {
    state = const AsyncLoading();
    try {
      // Support "trackingNumber|token" (ancien) et "trackingNumber" (nouveau)
      final trackingNumber = qrContent.trim().split('|').first;

      if (trackingNumber.isEmpty) {
        const msg = 'QR code invalide: trackingNumber manquant';
        state = AsyncError(msg, StackTrace.current);
        return Left(ServerFailure(msg));
      }

      final ds = ConfirmDeliveryDataSourceImpl(DioClient());
      await ds.confirm(trackingNumber);

      // ✅ Succès → state AsyncData → dialog succès s'affiche
      state = const AsyncData(null);
      return const Right(null);

    } on DioException catch (e) {
      String msg;
      final responseData = e.response?.data;
      if (responseData is Map<String, dynamic>) {
        msg = responseData['message'] as String? ??
            responseData['error'] as String? ??
            'Erreur serveur (${e.response?.statusCode})';
      } else if (responseData is String && responseData.isNotEmpty) {
        msg = responseData;
      } else {
        msg = 'Erreur lors de la confirmation: ${e.message}';
      }

      state = AsyncError(msg, StackTrace.current);
      return Left(ServerFailure(msg));

    } catch (e) {
      final errorMsg = e.toString();
      state = AsyncError(errorMsg, StackTrace.current);
      return Left(ServerFailure(errorMsg));
    }
  }
}

final confirmDeliveryProvider =
    StateNotifierProvider<ConfirmDeliveryNotifier, AsyncValue<void>>((ref) {
      return ConfirmDeliveryNotifier();
    });

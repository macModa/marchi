import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/bon_livraison_model.dart';

abstract class BonLivraisonRemoteDataSource {
  Future<BonLivraisonModel> getBonLivraison(int orderId);
}

class BonLivraisonRemoteDataSourceImpl implements BonLivraisonRemoteDataSource {
  final DioClient _client;

  const BonLivraisonRemoteDataSourceImpl(this._client);

  @override
  Future<BonLivraisonModel> getBonLivraison(int orderId) async {
    try {
      final response = await _client.get(ApiConstants.bonLivraison(orderId));
      
      // ✅ Handle 403 Forbidden specifically
      if (response.statusCode == 403) {
        throw ForbiddenException(
          'Accès interdit: vous n\'avez pas la permission d\'accéder à ce bon de livraison. '
          'Cette ressource nécessite le rôle ADMIN ou ARTISAN.',
          code: '403',
        );
      }
      
      if (response.statusCode == 401) {
        throw UnauthorizedException(
          'Session expirée ou non autorisée. Veuillez vous reconnecter.',
          code: '401',
        );
      }
      
      if (response.data is Map<String, dynamic>) {
        return BonLivraisonModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException(
        response.data?.toString() ?? 'Format de réponse invalide',
        code: response.statusCode?.toString(),
      );
    } on DioException catch (e) {
      // ✅ Handle DioException specifically
      if (e.response?.statusCode == 403) {
        throw ForbiddenException(
          'Accès interdit: vous n\'avez pas la permission d\'accéder à ce bon de livraison.',
          code: '403',
        );
      }
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(
          'Session expirée ou non autorisée. Veuillez vous reconnecter.',
          code: '401',
        );
      }
      // Re-throw other DioExceptions
      throw ServerException(
        e.message ?? 'Erreur de connexion',
        code: e.response?.statusCode?.toString(),
      );
    }
  }
}

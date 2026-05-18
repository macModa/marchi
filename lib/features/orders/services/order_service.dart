import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;
import '../../../core/storage/secure_storage.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/paged_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/order_dto.dart';
import '../models/create_order_request.dart';

class OrderService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<OrderDto>> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.orders,
        data: request.toJson(),
      );

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<OrderDto>> getOrderById(int id) async {
    try {
      final response = await _dioClient.get(ApiConstants.orderById(id));

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<OrderDto>>> getMyOrders({
    String? statut,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.myOrders,
        queryParameters: {
          'statut': ?statut,
          'page': page,
          'size': size,
        },
      );

      return ApiResponse<PagedResponse<OrderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<OrderDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => OrderDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<OrderDto>>> getArtisanOrders({
    String? statut,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.artisanOrders,
        queryParameters: {
          'statut': ?statut,
          'page': page,
          'size': size,
        },
      );

      return ApiResponse<PagedResponse<OrderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<OrderDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => OrderDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<OrderDto>> cancelOrder(int id) async {
    try {
      final response = await _dioClient.put(ApiConstants.cancelOrder(id));

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  /// ✅ Confirme la livraison via scan QR
  /// POST /api/v1/delivery/qr/confirm
  /// Body: { "qrToken": "<TOKEN>", "trackingNumber": "<TOKEN>" }
  /// Le backend peut retourner du JSON OU du texte brut → parsing défensif
  Future<Map<String, dynamic>> confirmDeliveryByQr({
    required String qrToken,
    required String trackingNumber,
  }) async {
    try {
      final url = ApiConstants.confirmDeliveryByQr;
      print('🔗 POST $url');
      print('📦 QR Token: $qrToken');
      print('📍 Tracking: $trackingNumber');

      final token = await SecureStorage().getToken();
      if (token == null) throw Exception('Non authentifié');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'qrToken': qrToken,
          'trackingNumber': trackingNumber,
        }),
      );

      print('📤 Response status: ${response.statusCode}');
      print('📤 Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Parsing défensif : le backend peut retourner JSON ou texte brut
        final body = response.body.trim();
        if (body.isNotEmpty && body.startsWith('{')) {
          try {
            final data = jsonDecode(body) as Map<String, dynamic>;
            print('✅ Livraison confirmée (JSON): $data');
            return data;
          } catch (_) {
            // Parsing JSON échoué → traiter comme succès texte brut
          }
        }
        // Texte brut ou corps vide → succès
        print('✅ Livraison confirmée (texte brut): $body');
        return {'success': true, 'message': body.isNotEmpty ? body : 'Livraison confirmée'};
      } else {
        // Erreur HTTP → parsing défensif du corps d'erreur
        String errorMsg = 'Erreur API ${response.statusCode}';
        final body = response.body.trim();
        if (body.isNotEmpty && body.startsWith('{')) {
          try {
            final error = jsonDecode(body) as Map<String, dynamic>;
            errorMsg = error['message']?.toString() ??
                error['error']?.toString() ??
                errorMsg;
          } catch (_) {
            if (body.isNotEmpty) errorMsg = body;
          }
        } else if (body.isNotEmpty) {
          errorMsg = body;
        }
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('❌ Erreur confirmDeliveryByQr: $e');
      rethrow;
    }
  }

  /// 📄 Télécharge et ouvre le bon de livraison (PDF)
  /// GET /api/delivery/bon-livraison/{orderId}
  Future<void> downloadAndOpenDeliveryNote(int orderId) async {
    try {
      final url = ApiConstants.deliveryNote(orderId);
      print('🔗 GET $url');

      final token = await SecureStorage().getToken();
      if (token == null) throw Exception('Non authentifié');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('📤 Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Vérifier que c'est bien un PDF
        final contentType = response.headers['content-type'] ?? '';
        if (!contentType.contains('pdf')) {
          throw Exception('Réponse inattendue du serveur (pas un PDF)');
        }

        final bytes = response.bodyBytes;
        // Utiliser le dossier temporaire (compatible iOS & Android)
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/bon_livraison_$orderId.pdf');
        await file.writeAsBytes(bytes);

        print('💾 Fichier sauvegardé: ${file.path}');

        // Ouvrir avec l'app PDF native du téléphone
        final result = await OpenFilex.open(file.path);
        if (result.type != ResultType.done) {
          throw Exception('Impossible d\'ouvrir le PDF: ${result.message}');
        }
        print('✅ PDF ouvert');
      } else {
        // Essayer de lire le message d'erreur du backend
        String errorMsg = 'Erreur ${response.statusCode}';
        try {
          final body = jsonDecode(response.body) as Map<String, dynamic>;
          errorMsg = body['message'] ?? errorMsg;
        } catch (_) {}
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('❌ Erreur downloadAndOpenDeliveryNote: $e');
      throw ErrorHandler.handleException(e);
    }
  }


  /// ✅ Artisan met à jour le statut de sa commande
  /// PUT /api/orders/{id}/artisan-status?status=CONFIRMED|SHIPPED
  Future<ApiResponse<OrderDto>> updateOrderStatusByArtisan(int orderId, String status) async {
    try {
      final response = await _dioClient.put(
        ApiConstants.artisanUpdateStatus(orderId),
        queryParameters: {'status': status},
      );
      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  /// 🔲 Récupère le QR code pour la livraison
  /// GET /api/v1/delivery/qr/{trackingNumber}
  Future<Map<String, dynamic>> fetchQrCode(String trackingNumber) async {
    try {
      final url = ApiConstants.fetchQrCode(trackingNumber);
      print('🔗 GET $url');

      final token = await SecureStorage().getToken();
      if (token == null) throw Exception('Non authentifié');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('📤 Response: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print('✅ QR récupéré: $data');
        return data;
      } else {
        final error = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception(error['message'] ?? 'Erreur API ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur generateQrCode: $e');
      throw ErrorHandler.handleException(e);
    }
  }

  /// 🔧 ADMIN — Toutes les commandes avec filtre statut optionnel
  /// GET /api/orders?statut=...&page=...&size=...
  Future<ApiResponse<PagedResponse<OrderDto>>> getAllOrdersAdmin({
    String? statut,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.orders,
        queryParameters: {
          'statut': ?statut,
          'page': page,
          'size': size,
        },
      );
      return ApiResponse<PagedResponse<OrderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<OrderDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => OrderDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  /// 🔧 ADMIN — Change le statut d'une commande
  /// PUT /api/orders/{id}/status?status=...
  Future<ApiResponse<OrderDto>> updateOrderStatusAdmin(int orderId, String status) async {
    try {
      final response = await _dioClient.put(
        '${ApiConstants.orderById(orderId)}/status',
        queryParameters: {'status': status},
      );
      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
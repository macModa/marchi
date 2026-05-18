import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:logger/logger.dart';

class PdfService {
  final Logger _logger = Logger();

  /// Télécharge et ouvre le bon de livraison en PDF
  /// [orderId] - ID de la commande
  /// [token] - Token d'authentification JWT
  /// [baseUrl] - URL de base du backend (optionnel)
  Future<void> downloadBonLivraisonPdf({
    required int orderId,
    required String token,
    String baseUrl = 'https://marketspace-production.up.railway.app',
  }) async {
    try {
      _logger.i('Démarrage téléchargement PDF pour commande #$orderId');

      final url = '$baseUrl/api/v1/delivery/bon-livraison/$orderId/pdf';

      // Faire la requête GET
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/pdf',
            },
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Délai d\'attente dépassé'),
          );

      if (response.statusCode == 200) {
        _logger.i('PDF reçu avec succès (${response.bodyBytes.length} bytes)');

        // Obtenir le répertoire temporaire
        final dir = await getTemporaryDirectory();
        final fileName = 'bon_livraison_$orderId.pdf';
        final filePath = '${dir.path}/$fileName';

        // Écrire le fichier
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _logger.i('PDF sauvegardé: $filePath');

        // Ouvrir le fichier
        final result = await OpenFile.open(filePath);

        if (result.type == ResultType.done) {
          _logger.i('PDF ouvert avec succès');
        } else {
          _logger.w('Impossible d\'ouvrir le PDF: ${result.message}');
          rethrow;
        }
      } else {
        _logger.e('Erreur API: ${response.statusCode}');
        _logger.e('Réponse: ${response.body}');
        throw Exception('Erreur téléchargement PDF (${response.statusCode})');
      }
    } catch (e) {
      _logger.e('Erreur service PDF: $e');
      rethrow;
    }
  }

  /// Télécharge le PDF sans l'ouvrir (retourne le chemin du fichier)
  Future<String> downloadBonLivraisonPdfPath({
    required int orderId,
    required String token,
    String baseUrl = 'https://marketspace-production.up.railway.app',
  }) async {
    try {
      final url = '$baseUrl/api/v1/delivery/bon-livraison/$orderId/pdf';

      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/pdf',
            },
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Délai d\'attente dépassé'),
          );

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final fileName = 'bon_livraison_$orderId.pdf';
        final filePath = '${dir.path}/$fileName';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _logger.i('PDF sauvegardé: $filePath');
        return filePath;
      } else {
        throw Exception('Erreur téléchargement PDF (${response.statusCode})');
      }
    } catch (e) {
      _logger.e('Erreur service PDF: $e');
      rethrow;
    }
  }
}

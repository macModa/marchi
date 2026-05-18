import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../providers/delivery_provider.dart';

class ClientScanScreen extends ConsumerStatefulWidget {
  const ClientScanScreen({super.key});

  @override
  ConsumerState<ClientScanScreen> createState() => _ClientScanScreenState();
}

class _ClientScanScreenState extends ConsumerState<ClientScanScreen> {
  bool _isScanning = true;

  void _onDetect(BarcodeCapture capture) async {
    if (!_isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;
      if (code != null) {
        debugPrint('QR Code détecté: $code');
        
        // Parsing de l'URL : /api/orders/{id}/validate-delivery?token=XYZ
        try {
          final uri = Uri.parse(code);
          final pathSegments = uri.pathSegments;
          
          // Recherche du pattern /api/orders/{id}/validate-delivery
          int? orderId;
          String? token;

          // Support pour URL complète ou chemin relatif
          for (int i = 0; i < pathSegments.length; i++) {
            if (pathSegments[i] == 'orders' && i + 2 < pathSegments.length && pathSegments[i+2] == 'validate-delivery') {
              orderId = int.tryParse(pathSegments[i+1]);
              break;
            }
          }
          
          token = uri.queryParameters['token'];

          if (orderId != null && token != null) {
            setState(() => _isScanning = false);
            
            // Appel de la validation via le provider
            await ref.read(deliveryValidationProvider.notifier).validate(orderId, token);
            
            if (mounted) {
              final result = ref.read(deliveryValidationProvider);
              result.when(
                data: (success) {
                  if (success) {
                    _showSuccessDialog();
                  } else {
                    _showErrorDialog('Ce bon de livraison n\'a pas pu être validé.');
                  }
                },
                error: (err, _) => _showErrorDialog(err.toString()),
                loading: () {},
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Format de QR code non reconnu.'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } catch (e) {
          debugPrint('Error parsing QR code: $e');
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text('Livraison validée avec succès ! Merci de votre confiance.',
            textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialog
              Navigator.of(context).pop(); // Retourner à l'écran précédent
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.error, color: Colors.red, size: 60),
        content: Text('Erreur : $message', textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _isScanning = true); // Reprendre le scan
            },
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner le Bon de Livraison'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
            ),
            onDetect: _onDetect,
          ),
          // Overlay de scan
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Text(
              'Alignez le QR code dans le cadre',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          if (ref.watch(deliveryValidationProvider).isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

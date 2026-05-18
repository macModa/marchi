import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/services/role_service.dart';
import '../providers/order_providers.dart';

class ScanQrPage extends ConsumerStatefulWidget {
  final int orderId;

  const ScanQrPage({super.key, required this.orderId});

  @override
  ConsumerState<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends ConsumerState<ScanQrPage> {
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _checkAccess();
  }

  void _checkAccess() async {
    final isClient = await RoleService.isClient();
    if (!isClient) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Accès refusé : cette fonctionnalité est réservée aux clients."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void handleScan(String raw) async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      // ✅ Le QR contient une String brute (ex: "MRK-2-1778527242652")
      // Ne pas tenter de parser en JSON — utiliser directement comme token
      final token = raw.trim();
      print('🔍 QR Data scanné: $token');

      if (token.isEmpty) {
        throw Exception('QR invalide: code vide');
      }

      print('📦 Token / Tracking: $token');

      // Appel API via le service
      final orderService = ref.read(orderServiceProvider);
      await orderService.confirmDeliveryByQr(
        qrToken: token,
        trackingNumber: token,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Livraison confirmée avec succès!"),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh orders list
        ref.invalidate(myOrdersProvider);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner QR Livraison")),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  handleScan(code);
                }
              }
            },
          ),
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      "Validation en cours...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

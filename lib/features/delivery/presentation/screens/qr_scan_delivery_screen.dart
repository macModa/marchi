import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../providers/confirm_delivery_provider.dart';
import '../../../orders/providers/order_providers.dart'; // ← import du provider

/// Écran CLIENT : scanner le QR code du bon de livraison pour confirmer.
class QrScanDeliveryScreen extends ConsumerStatefulWidget {
  const QrScanDeliveryScreen({super.key, required this.orderId});

  final int orderId;

  @override
  ConsumerState<QrScanDeliveryScreen> createState() =>
      _QrScanDeliveryScreenState();
}

class _QrScanDeliveryScreenState extends ConsumerState<QrScanDeliveryScreen> {
  final MobileScannerController _scanner = MobileScannerController();
  bool _processing = false;

  @override
  void dispose() {
    _scanner.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_processing) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null) return;

    _processing = true;
    await _scanner.stop();

    if (!mounted) return;

    final token = raw.trim();

    final result = await ref
        .read(confirmDeliveryProvider.notifier)
        .confirm(token);

    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Colors.red.shade700,
          ),
        );
        _scanner.start();
        _processing = false;
      },
      (_) {
        // ✅ Rafraîchir la liste des commandes (artisan + client)
        ref.invalidate(artisanOrdersProvider);
        ref.invalidate(myOrdersProvider);

        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => _SuccessDialog(orderId: widget.orderId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(confirmDeliveryProvider) is AsyncLoading<void>;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Confirmer la réception'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: _scanner.toggleTorch,
            tooltip: 'Lampe torche',
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _scanner,
            onDetect: _onDetect,
          ),
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade400, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Text(
              'Scannez le QR code\ndu bon de livraison',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 0.85),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Icon(Icons.check_circle_rounded,
              color: Colors.green.shade600, size: 72),
          const SizedBox(height: 16),
          const Text(
            'Livraison confirmée !',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Commande #$orderId marquée comme livrée.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.of(context)
                  ..pop()  // dialog
                  ..pop(); // QrScanDeliveryScreen
              },
              child: const Text('Retour à mes commandes'),
            ),
          ),
        ],
      ),
    );
  }
}
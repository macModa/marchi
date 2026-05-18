import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_status.dart';
import '../../../../shared/widgets/order_card.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/storage/secure_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../services/order_service.dart';
import '../providers/order_providers.dart';

class ArtisanOrdersScreen extends ConsumerStatefulWidget {
  const ArtisanOrdersScreen({super.key});

  @override
  ConsumerState<ArtisanOrdersScreen> createState() =>
      _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState extends ConsumerState<ArtisanOrdersScreen> {
  int _page = 0;
  String? _selectedStatut;
  String? _token;

  final List<String> _statuts = [
    'PENDING',
    'CONFIRMED',
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED',
  ];

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final t = await SecureStorage().getToken();
    debugPrint('🔑 TOKEN CHARGE: ${t != null ? "${t.substring(0, 20)}..." : "NULL"}');
    if (mounted) setState(() => _token = t);
  }

  String? _pdfUrl(int orderId) {
    if (_token == null) return null;
    return '${ApiConstants.deliveryNote(orderId)}?token=$_token';
  }

  Future<void> _updateStatus(int orderId, String status) async {
    debugPrint('🚀 _updateStatus appelé: orderId=$orderId, status=$status');
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mise a jour en cours...')),
      );

      debugPrint('📡 Appel API updateOrderStatusByArtisan...');
      await OrderService().updateOrderStatusByArtisan(orderId, status);
      debugPrint('✅ API appel réussi pour order #$orderId → $status');

      ref.invalidate(artisanOrdersProvider);
      debugPrint('🔄 Provider invalidé, refresh en cours...');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(status == 'CONFIRMED'
                ? 'Commande confirmee !'
                : 'Commande expediee !'),
          ),
        );
      }
    } catch (e, stack) {
      debugPrint('❌ ERREUR _updateStatus: $e');
      debugPrint('📋 Stack trace: $stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(
      artisanOrdersProvider((page: _page, size: 20, statut: _selectedStatut)),
    );

    const userRole = 'ARTISAN';

    return Scaffold(
      appBar: AppBar(title: const Text('Commandes Recues')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Tous'),
                  selected: _selectedStatut == null,
                  onSelected: (_) => setState(() {
                    _selectedStatut = null;
                    _page = 0;
                  }),
                ),
                ..._statuts.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      label: Text(s),
                      selected: _selectedStatut == s,
                      onSelected: (_) => setState(() {
                        _selectedStatut = s;
                        _page = 0;
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ordersAsync.when(
              data: (pagedResponse) {
                final orders = pagedResponse.content;

                debugPrint('=== ARTISAN DEBUG: ${orders.length} commandes ===');
                for (final o in orders) {
                  debugPrint(
                    'Order #${o.id} '
                    '| statut: ${o.statut} '
                    '| isPending: ${o.statut == OrderStatus.pending} '
                    '| isConfirmed: ${o.statut == OrderStatus.confirmed}',
                  );
                }

                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined,
                            size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('Aucune commande recue.'),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(
                            AppConstants.defaultPadding),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          // DEBUG par card
                          debugPrint(
                            '🃏 Card #${order.id}: statut=${order.statut}, '
                            'onConfirm=${order.statut == OrderStatus.pending ? "SET" : "NULL"}, '
                            'onShip=${order.statut == OrderStatus.confirmed ? "SET" : "NULL"}',
                          );

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              children: [
                                OrderCard(
                                  order: order,
                                  userRole: userRole,
                                  subtitle:
                                      '${order.orderLines.length} produit(s) · ${order.clientNom}',
                                  pdfUrl: _pdfUrl(order.id),
                                  onConfirm: order.statut ==
                                          OrderStatus.pending
                                      ? () {
                                          debugPrint(
                                              '👆 Bouton Confirmer cliqué pour #${order.id}');
                                          _updateStatus(
                                              order.id, 'CONFIRMED');
                                        }
                                      : null,
                                  onShip: order.statut ==
                                          OrderStatus.confirmed
                                      ? () {
                                          debugPrint(
                                              '👆 Bouton Expédier cliqué pour #${order.id}');
                                          _updateStatus(order.id, 'SHIPPED');
                                        }
                                      : null,
                                ),

                                if (order.statut == OrderStatus.shipped &&
                                    order.deliveryToken != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: () =>
                                            _showQrDialog(context, order),
                                        icon: const Icon(Icons.qr_code),
                                        label: const Text(
                                            'Afficher QR Livraison'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: const Color(
                                            AppConstants.colorPrimary,
                                          ),
                                          side: const BorderSide(
                                            color: Color(
                                                AppConstants.colorPrimary),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                              AppConstants.borderRadius,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: _page > 0
                                ? () => setState(() => _page--)
                                : null,
                          ),
                          Text(
                            'Page ${_page + 1} / ${pagedResponse.totalPages == 0 ? 1 : pagedResponse.totalPages}',
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed:
                                _page < (pagedResponse.totalPages - 1)
                                    ? () => setState(() => _page++)
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('Erreur: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showQrDialog(BuildContext context, dynamic order) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Récupération du QR code...'),
          ],
        ),
      ),
    );

    try {
      if (order.trackingNumber == null || order.trackingNumber.isEmpty) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur: Numero de suivi manquant'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final qrResponse =
          await OrderService().fetchQrCode(order.trackingNumber);
      if (!context.mounted) return;
      Navigator.pop(context);

      final qrCodeBase64 = qrResponse['qrCodeBase64'] ?? '';
      final qrToken = qrResponse['qrToken'] ?? '';
      final trackingNumber =
          qrResponse['trackingNumber'] ?? order.trackingNumber;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('QR Livraison - #${order.id}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Le client doit scanner ce code pour confirmer la livraison.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: qrCodeBase64.isNotEmpty
                    ? Image.memory(
                        base64Decode(
                          qrCodeBase64.replaceFirst(
                              'data:image/png;base64,', ''),
                        ),
                        width: 200,
                        height: 200,
                      )
                    : QrImageView(
                        data: jsonEncode({
                          'trackingNumber': trackingNumber,
                          'token': qrToken,
                        }),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                'Suivi: $trackingNumber',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

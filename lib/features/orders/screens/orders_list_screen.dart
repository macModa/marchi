import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../providers/order_providers.dart';
import '../services/order_service.dart';
import '../models/order_status.dart';
import '../../../../shared/widgets/order_card.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/storage/secure_storage.dart';
import 'package:marchi/features/auth/providers/auth_providers.dart';

class OrdersListScreen extends ConsumerStatefulWidget {
  const OrdersListScreen({super.key});

  @override
  ConsumerState<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends ConsumerState<OrdersListScreen> {
  int _page = 0;
  String? _selectedStatut;
  String? _token;

  final List<String> _statuts = ['PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED'];

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final t = await SecureStorage().getToken();
    if (mounted) setState(() => _token = t);
  }

  String? _pdfUrl(int orderId) {
    if (_token == null) return null;
    return '${ApiConstants.deliveryNote(orderId)}?token=$_token';
  }

  // ✅ FIX: méthode pour mettre à jour le statut d'une commande (ARTISAN)
  Future<void> _updateStatus(int orderId, String status) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mise à jour en cours...')),
      );
      await OrderService().updateOrderStatusByArtisan(orderId, status);
      ref.invalidate(myOrdersProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              status == 'CONFIRMED' ? 'Commande confirmée !' : 'Commande expédiée !',
            ),
          ),
        );
      }
    } catch (e) {
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
      myOrdersProvider((page: _page, size: 20, statut: _selectedStatut)),
    );
    final userRole = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Commandes'),
      ),
      body: Column(
        children: [
          // ── Filtres de statut ────────────────────────────────────────────
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
                ..._statuts.map((s) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FilterChip(
                        label: Text(s),
                        selected: _selectedStatut == s,
                        onSelected: (_) => setState(() {
                          _selectedStatut = s;
                          _page = 0;
                        }),
                      ),
                    )),
              ],
            ),
          ),

          // ── Liste des commandes ──────────────────────────────────────────
          Expanded(
            child: ordersAsync.when(
              data: (pagedResponse) {
                final orders = pagedResponse.content;
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_outlined,
                            size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('Vous n\'avez pas encore de commandes.'),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () => context.go('/home'),
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.brown[700]),
                          child: const Text('Découvrir les produits'),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppConstants.defaultPadding),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: OrderCard(
                              order: order,
                              userRole: userRole,
                              onTap: () {},
                              pdfUrl: _pdfUrl(order.id),
                              // ✅ FIX: onConfirm passé pour ARTISAN + PENDING
                              onConfirm: order.statut == OrderStatus.pending
                                  ? () => _updateStatus(order.id, 'CONFIRMED')
                                  : null,
                              // ✅ FIX: onShip passé pour ARTISAN + CONFIRMED
                              onShip: order.statut == OrderStatus.confirmed
                                  ? () => _updateStatus(order.id, 'SHIPPED')
                                  : null,
                              // ✅ Scanner pour CLIENT
                              onScan: () => _openScanner(context, order.id),
                            ),
                          );
                        },
                      ),
                    ),

                    // ── Pagination ───────────────────────────────────────
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
                            onPressed: _page < (pagedResponse.totalPages - 1)
                                ? () => setState(() => _page++)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erreur: $err')),
            ),
          ),
        ],
      ),
    );
  }

  void _openScanner(BuildContext context, int orderId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Scanner le QR de livraison',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pointez la caméra vers le QR code affiché par l\'artisan',
              style: TextStyle(color: Colors.white60, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: MobileScanner(
                  onDetect: (capture) {
                    final barcode = capture.barcodes.first;
                    if (barcode.rawValue != null) {
                      Navigator.pop(context);
                      _onQrScanned(context, barcode.rawValue!);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onQrScanned(BuildContext context, String rawQrData) async {
    // ✅ Le QR contient une String brute (ex: "MRK-2-1778527242652")
    // Ne pas tenter de parser en JSON — utiliser directement comme token
    final token = rawQrData.trim();

    if (token.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ QR invalide: code vide'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Validation en cours...'),
              ],
            ),
          ),
        );
      }

      final orderService = OrderService();
      await orderService.confirmDeliveryByQr(
        qrToken: token,
        trackingNumber: token,
      );

      if (context.mounted) {
        Navigator.pop(context); // ferme le dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Livraison confirmée avec succès!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        ref.invalidate(myOrdersProvider);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // ferme le dialog si ouvert
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}

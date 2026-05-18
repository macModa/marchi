import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_dto.dart';
import '../providers/order_providers.dart';
import '../services/order_service.dart';
import '../../../../core/constants/app_constants.dart';

class AdminOrdersScreen extends ConsumerStatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  ConsumerState<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends ConsumerState<AdminOrdersScreen> {
  int _page = 0;
  String? _selectedStatut;
  bool _isUpdating = false;

  final List<String> _statuts = [
    'PENDING',
    'CONFIRMED',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED',
  ];

  final Map<String, String> _statutLabels = {
    'PENDING':   'En attente',
    'CONFIRMED': 'Confirmée',
    'SHIPPED':   'Expédiée',
    'DELIVERED': 'Livrée',
    'CANCELLED': 'Annulée',
  };

  final Map<String, Color> _statutColors = {
    'PENDING':   Colors.orange,
    'CONFIRMED': Colors.blue,
    'SHIPPED':   Colors.purple,
    'DELIVERED': Colors.green,
    'CANCELLED': Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(
      adminOrdersProvider((page: _page, size: 20, statut: _selectedStatut)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: Color(AppConstants.colorPrimary),
        foregroundColor: Colors.white,
        title: const Text(
          'Dashboard Admin — Commandes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminOrdersProvider),
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Stats bar ───────────────────────────────────────────────────
          ordersAsync.when(
            data: (paged) => Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${paged.totalElements} commande(s) au total',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Page ${_page + 1} / ${paged.totalPages == 0 ? 1 : paged.totalPages}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),

          // ── Filtres statut ───────────────────────────────────────────────
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  _filterChip('Tous', null),
                  ..._statuts.map((s) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _filterChip(s, s),
                      )),
                ],
              ),
            ),
          ),

          const Divider(height: 1),

          // ── Liste commandes ──────────────────────────────────────────────
          Expanded(
            child: ordersAsync.when(
              data: (pagedResponse) {
                final orders = pagedResponse.content;
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune commande',
                          style: TextStyle(color: Colors.grey[500], fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: orders.length,
                        itemBuilder: (context, index) =>
                            _AdminOrderCard(
                          order: orders[index],
                          statutLabels: _statutLabels,
                          statutColors: _statutColors,
                          statuts: _statuts,
                          isUpdating: _isUpdating,
                          onStatusChange: (orderId, newStatus) =>
                              _updateStatus(orderId, newStatus),
                        ),
                      ),
                    ),

                    // ── Pagination ─────────────────────────────────────────
                    Container(
                      color: Colors.white,
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
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
              error: (err, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Erreur: $err', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(adminOrdersProvider),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, String? value) {
    final isSelected = _selectedStatut == value;
    final color = value != null
        ? (_statutColors[value] ?? Colors.grey)
        : Color(AppConstants.colorPrimary);

    return FilterChip(
      label: Text(
        value != null ? (_statutLabels[value] ?? label) : label,
        style: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => setState(() {
        _selectedStatut = value;
        _page = 0;
      }),
      selectedColor: color,
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.4)),
      showCheckmark: false,
    );
  }

  Future<void> _updateStatus(int orderId, String newStatus) async {
    setState(() => _isUpdating = true);
    try {
      await OrderService().updateOrderStatusAdmin(orderId, newStatus);
      ref.invalidate(adminOrdersProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '✅ Commande #$orderId → ${_statutLabels[newStatus] ?? newStatus}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }
}

// ── Card commande admin ─────────────────────────────────────────────────────
class _AdminOrderCard extends StatelessWidget {
  final OrderDto order;
  final Map<String, String> statutLabels;
  final Map<String, Color> statutColors;
  final List<String> statuts;
  final bool isUpdating;
  final Function(int, String) onStatusChange;

  const _AdminOrderCard({
    required this.order,
    required this.statutLabels,
    required this.statutColors,
    required this.statuts,
    required this.isUpdating,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final statusStr = order.statut.name.toUpperCase();
    final statusColor = statutColors[statusStr] ?? Colors.grey;
    final statusLabel = statutLabels[statusStr] ?? statusStr;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Commande #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ── Infos ──
            Row(
              children: [
                Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  order.clientNom ?? 'Client inconnu',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const SizedBox(width: 16),
                Icon(Icons.calendar_today_outlined,
                    size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  order.dateCreation.toString().substring(0, 10),
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(Icons.shopping_bag_outlined,
                    size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${order.orderLines.length} article(s)',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '${order.total.toStringAsFixed(2)} TND',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.brown[700],
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            // ── Changer statut ──
            Row(
              children: [
                Text(
                  'Changer statut:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: isUpdating
                      ? const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : DropdownButton<String>(
                          value: statusStr,
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          items: statuts.map((s) {
                            final color = statutColors[s] ?? Colors.grey;
                            return DropdownMenuItem(
                              value: s,
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    statutLabels[s] ?? s,
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newStatus) {
                            if (newStatus != null && newStatus != statusStr) {
                              onStatusChange(order.id, newStatus);
                            }
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

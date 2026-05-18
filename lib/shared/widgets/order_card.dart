import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/orders/models/order_dto.dart';
import '../../features/orders/models/order_status.dart';
import '../../core/constants/app_constants.dart';

class OrderCard extends StatefulWidget {
  final OrderDto order;
  final VoidCallback? onTap;
  final String? subtitle;
  final String? pdfUrl;
  final VoidCallback? onScan;
  final VoidCallback? onConfirm;
  final VoidCallback? onShip;
  final String? userRole;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.subtitle,
    this.pdfUrl,
    this.onScan,
    this.onConfirm,
    this.onShip,
    this.userRole,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isDownloading = false;

  Future<void> _openPdf() async {
    if (widget.pdfUrl == null) return;

    // ── WEB : ouvrir dans un nouvel onglet ──────────────────────────────────
    if (kIsWeb) {
      final uri = Uri.parse(widget.pdfUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return;
    }

    // ── MOBILE : télécharger + ouvrir avec l'app PDF native ─────────────────
    setState(() => _isDownloading = true);
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/bon_livraison_${widget.order.id}.pdf';

      final file = File(filePath);
      if (await file.exists()) await file.delete();

      await Dio().download(widget.pdfUrl!, filePath);

      final result = await OpenFilex.open(filePath); // ✅ fixed
      if (result.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Impossible d\'ouvrir le PDF: ${result.message}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Erreur téléchargement PDF: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArtisan = widget.userRole != null &&
        widget.userRole!.toUpperCase().contains('ARTISAN');
    final isClient = widget.userRole != null &&
        widget.userRole!.toUpperCase().contains('CLIENT');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── En-tête : numéro + badge statut ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commande #${widget.order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _StatusBadge(status: widget.order.statut),
                ],
              ),
              const SizedBox(height: 8),

              // ── Date ──
              Text(
                'Date: ${widget.order.dateCreation}',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),

              // ── Sous-titre optionnel ──
              if (widget.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  widget.subtitle!,
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 12),

              // ── Articles + total ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.order.orderLines.length} article(s)',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${widget.order.total.toStringAsFixed(2)} TND',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              // ── Actions (selon rôle) ──
              if (widget.userRole != null) ...[
                const SizedBox(height: 12),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    // 📄 PDF — ARTISAN uniquement
                    if (isArtisan && widget.pdfUrl != null)
                      TextButton.icon(
                        onPressed: _isDownloading ? null : _openPdf,
                        icon: _isDownloading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.red,
                                ),
                              )
                            : const Icon(Icons.picture_as_pdf, color: Colors.red),
                        label: Text(
                          _isDownloading ? 'Chargement...' : 'Télécharger PDF',
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.brown[700],
                        ),
                      ),

                    // ✅ Confirmer — ARTISAN + statut PENDING
                    if (isArtisan && widget.order.statut == OrderStatus.pending)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton.icon(
                          onPressed: widget.onConfirm ??
                              () => debugPrint(
                                  '⚠️ onConfirm non fourni pour #${widget.order.id}'),
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Confirmer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                    // 🚚 Expédier — ARTISAN + statut CONFIRMED
                    if (isArtisan && widget.order.statut == OrderStatus.confirmed)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton.icon(
                          onPressed: widget.onShip ??
                              () => debugPrint(
                                  '⚠️ onShip non fourni pour #${widget.order.id}'),
                          icon: const Icon(Icons.local_shipping),
                          label: const Text('Expédier'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                    // 📷 Scanner — CLIENT uniquement
                    if (isClient)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton.icon(
                          onPressed: widget.onScan,
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text('Scanner'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(AppConstants.colorPrimary),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderRadius,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case OrderStatus.pending:
        color = Colors.orange;
        label = 'En attente';
        break;
      case OrderStatus.confirmed:
        color = Colors.blue;
        label = 'Confirmée';
        break;
      case OrderStatus.processing:
        color = Colors.indigo;
        label = 'En cours';
        break;
      case OrderStatus.shipped:
        color = Colors.purple;
        label = 'Expédiée';
        break;
      case OrderStatus.delivered:
        color = Colors.green;
        label = 'Livrée';
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        label = 'Annulée';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

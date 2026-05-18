import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delivery_providers.dart';
import '../../domain/entities/parcel.dart';

class ParcelDetailsScreen extends ConsumerWidget {
  final String trackingNumber;

  const ParcelDetailsScreen({super.key, required this.trackingNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncParcel = ref.watch(parcelByTrackingProvider(trackingNumber));

    return Scaffold(
      appBar: AppBar(title: const Text('Détails du Colis')),
      body: asyncParcel.when(
        data: (either) => either.fold(
          (failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(failure.message, textAlign: TextAlign.center),
                TextButton(
                  onPressed: () =>
                      ref.invalidate(parcelByTrackingProvider(trackingNumber)),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
          (parcel) => _buildParcelDetails(context, parcel),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Erreur inattendue: $error')),
      ),
    );
  }

  Widget _buildParcelDetails(BuildContext context, Parcel parcel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Informations Générales'),
        _buildInfoRow('N° de Suivi', parcel.trackingNumber),
        _buildInfoRow('Statut', parcel.status, isStatus: true),
        if (parcel.createdAt != null)
          _buildInfoRow('Date de création', _formatDate(parcel.createdAt!)),
        if (parcel.estimatedDeliveryDate != null)
          _buildInfoRow(
            'Livraison estimée',
            _formatDate(parcel.estimatedDeliveryDate!),
          ),

        const Divider(height: 32),

        _buildSectionHeader('Destinataire'),
        _buildInfoRow('Nom', parcel.recipientName),
        _buildInfoRow('Téléphone', parcel.recipientPhone),
        if (parcel.recipientAddress != null)
          _buildInfoRow('Adresse', parcel.recipientAddress!),

        const Divider(height: 32),

        _buildSectionHeader('Détails d\'expédition'),
        if (parcel.weight != null)
          _buildInfoRow('Poids', '${parcel.weight} kg'),
        if (parcel.price != null) _buildInfoRow('Prix', '${parcel.price} TND'),
        if (parcel.relayPointId != null)
          _buildInfoRow('ID Point Relais', '${parcel.relayPointId}'),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold, // ✅ FIXED: supprimé la constante globale illégale
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: isStatus
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        // ✅ FIXED: withOpacity() remplacé par Color.fromRGBO
                        color: Color.fromRGBO(
                          _getStatusColor(value).r.toInt(),
                          _getStatusColor(value).g.toInt(),
                          _getStatusColor(value).b.toInt(),
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getStatusColor(value)),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: _getStatusColor(value),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
        return Colors.green;
      case 'IN_TRANSIT':
        return Colors.blue;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

// ✅ FIXED: supprimé "const FontWeight bold = FontWeight.bold;" — illégal en Dart (const top-level non-primitive)

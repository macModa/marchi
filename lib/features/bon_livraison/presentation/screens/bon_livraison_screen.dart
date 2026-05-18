import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bon_livraison_entity.dart';
import '../providers/bon_livraison_providers.dart';
import '../widgets/actions_section.dart';
import '../widgets/colis_details_card.dart';
import '../widgets/destinataire_card.dart';
import '../widgets/expediteur_card.dart';
import '../widgets/header_card.dart';
import '../pdf/bon_livraison_pdf.dart';

class BonLivraisonScreen extends ConsumerWidget {
  final int orderId;

  const BonLivraisonScreen({super.key, required this.orderId});

  static const _green = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBon = ref.watch(bonLivraisonProvider(orderId));

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Bon de Livraison',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('ALDER AgriTech',
                style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        actions: [
          asyncBon.when(
            data: (either) => either.fold(
              (_) => const SizedBox.shrink(),
              (bon) => TextButton.icon(
                onPressed: () => BonLivraisonPdf.printOrShare(bon),
                icon: const Icon(Icons.print, color: Colors.white, size: 20),
                label: const Text('PDF',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: asyncBon.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: _green),
              SizedBox(height: 16),
              Text('Chargement du bon de livraison...',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 56),
                const SizedBox(height: 16),
                Text('Erreur inattendue\n$err',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.invalidate(bonLivraisonProvider(orderId)),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (either) => either.fold(
          (failure) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 56),
                  const SizedBox(height: 16),
                  Text(failure.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () =>
                        ref.invalidate(bonLivraisonProvider(orderId)),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reessayer'),
                  ),
                ],
              ),
            ),
          ),
          (bon) => _BonBody(bon: bon, orderId: orderId),
        ),
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────

class _BonBody extends StatelessWidget {
  final BonLivraisonEntity bon;
  final int orderId;

  const _BonBody({required this.bon, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      children: [
        HeaderCard(bon: bon),
        ExpediteurCard(expediteur: bon.expediteur),   // ← était ExpéditeurCard
        DestinataireCard(destinataire: bon.destinataire),
        ColisDetailsCard(bon: bon),
        ActionsSection(bon: bon),
        const SizedBox(height: 32),
      ],
    );
  }
}

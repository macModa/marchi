import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delivery_providers.dart';
import '../../domain/entities/tracking_event.dart';
import '../../../orders/providers/order_providers.dart';

class TrackingScreen extends ConsumerStatefulWidget {
  const TrackingScreen({super.key});

  @override
  ConsumerState<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends ConsumerState<TrackingScreen> {
  final _trackingController = TextEditingController();
  String? _submittedTracking;

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  void _search() {
    final tracking = _trackingController.text.trim();
    if (tracking.isNotEmpty) {
      setState(() {
        _submittedTracking = tracking;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de Colis')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _trackingController,
                    decoration: const InputDecoration(
                      labelText: 'Numéro de suivi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_shipping),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: _submittedTracking == null
                ? const Center(
                    child: Text(
                      'Entrez un numéro de suivi pour voir l\'historique.',
                    ),
                  )
                : _buildTrackingTimeline(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final asyncTimeline = ref.watch(
      trackingTimelineProvider(_submittedTracking!),
    );

    return asyncTimeline.when(
      data: (either) => either.fold(
        (failure) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(failure.message, textAlign: TextAlign.center),
              TextButton(
                onPressed: () => ref.invalidate(
                  trackingTimelineProvider(_submittedTracking!),
                ),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        (events) {
          if (events.isEmpty) {
            return const Center(
              child: Text('Aucun événement trouvé pour ce colis.'),
            );
          }

          // Sort events by descending timestamp (newest first)
          final sortedEvents = List<TrackingEvent>.from(events)
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          if (sortedEvents.isNotEmpty &&
              sortedEvents.first.status == 'DELIVERED') {
            // Auto refresh orders so the COD badge updates to PAID
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.invalidate(myOrdersProvider);
            });
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedEvents.length,
            itemBuilder: (context, index) {
              final event = sortedEvents[index];
              final isFirst = index == 0;
              final isLast = index == sortedEvents.length - 1;

              return _TrackingTimelineItem(
                event: event,
                isFirst: isFirst,
                isLast: isLast,
              );
            },
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur inattendue: $error')),
    );
  }
}

class _TrackingTimelineItem extends StatelessWidget {
  final TrackingEvent event;
  final bool isFirst;
  final bool isLast;

  const _TrackingTimelineItem({
    required this.event,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    // Basic timeline approach using IntrinsicHeight and Row
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline graphics
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFirst ? Colors.blueAccent : Colors.grey.shade400,
                    border: isFirst
                        ? Border.all(color: Colors.blue.shade100, width: 4)
                        : null,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.status,
                    style: TextStyle(
                      fontWeight: isFirst ? FontWeight.bold : FontWeight.w600,
                      fontSize: 16,
                      color: isFirst ? Colors.blueAccent : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (event.location != null)
                    Text(
                      event.location!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  if (event.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      event.description!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(event.timestamp),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple formatter, in real app use intl package
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

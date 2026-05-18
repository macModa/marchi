import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delivery_providers.dart';
import '../../domain/entities/relay_point.dart';

class RelaySelectionScreen extends ConsumerStatefulWidget {
  const RelaySelectionScreen({super.key});

  @override
  ConsumerState<RelaySelectionScreen> createState() =>
      _RelaySelectionScreenState();
}

class _RelaySelectionScreenState extends ConsumerState<RelaySelectionScreen> {
  final _postalCodeController = TextEditingController();
  String? _submittedPostalCode;

  @override
  void dispose() {
    _postalCodeController.dispose();
    super.dispose();
  }

  void _search() {
    final code = _postalCodeController.text.trim();
    if (code.isNotEmpty) {
      setState(() {
        _submittedPostalCode = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sélectionner un Point Relais')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Code Postal',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    keyboardType: TextInputType.number,
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
            child: _submittedPostalCode == null
                ? const Center(
                    child: Text(
                      'Entrez un code postal pour chercher des points relais.',
                    ),
                  )
                : _buildRelayList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRelayList() {
    final asyncRelays = ref.watch(
      relaysByPostalCodeProvider(_submittedPostalCode!),
    );

    return asyncRelays.when(
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
                  relaysByPostalCodeProvider(_submittedPostalCode!),
                ),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        (relays) {
          if (relays.isEmpty) {
            return const Center(child: Text('Aucun point relais trouvé.'));
          }

          return ListView.builder(
            itemCount: relays.length,
            itemBuilder: (context, index) {
              final relay = relays[index];
              return _RelayCard(relay: relay);
            },
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur inattendue: $error')),
    );
  }
}

class _RelayCard extends StatelessWidget {
  final RelayPoint relay;

  const _RelayCard({required this.relay});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.store, color: Colors.white),
        ),
        title: Text(
          relay.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('${relay.address}, ${relay.postalCode} ${relay.city}'),
            if (relay.openingHours != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    relay.openingHours!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Return selected relay point to the caller
          Navigator.of(context).pop(relay);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/payment_method.dart';
import '../models/create_payment_request.dart';
import '../services/payment_service.dart';
import '../providers/payment_service_provider.dart';
import '../../../../core/constants/app_constants.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final int orderId;

  const PaymentScreen({super.key, required this.orderId});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.bankTransfer;
  final _referenceController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    setState(() => _isLoading = true);

    try {
      final request = CreatePaymentRequest(
        methode: _selectedMethod,
        reference: _referenceController.text.trim().isEmpty ? null : _referenceController.text.trim(),
      );

      final response = await ref.read(paymentServiceProvider).createPayment(widget.orderId, request);

      if (response.success) {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Paiement Réussi !',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Votre commande a été payée avec succès.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    context.go('/home'); // Go to home
                  },
                  child: const Text('Retour à l\'accueil'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisir une méthode de paiement',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            RadioListTile<PaymentMethod>(
              title: const Text('Virement Bancaire'),
              subtitle: const Text('Payez par transfert bancaire (RIB disponible après confirmation)'),
              value: PaymentMethod.bankTransfer,
              groupValue: _selectedMethod,
              activeColor: Colors.brown[700],
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
            RadioListTile<PaymentMethod>(
              title: const Text('Espèce'),
              subtitle: const Text('Paiement à la livraison'),
              value: PaymentMethod.cash,
              groupValue: _selectedMethod,
              activeColor: Colors.brown[700],
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
            RadioListTile<PaymentMethod>(
              title: const Text('Carte Bancaire'),
              subtitle: const Text('Cette option sera bientôt disponible'),
              value: PaymentMethod.card,
              groupValue: _selectedMethod,
              activeColor: Colors.brown[700],
              onChanged: null, // Disabled for now as per usual Tunisian MVP pattern
            ),
            const SizedBox(height: 24),
            if (_selectedMethod == PaymentMethod.bankTransfer) ...[
              const Text(
                'Référence du virement (optionnel)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _referenceController,
                decoration: InputDecoration(
                  hintText: 'Ex: VIR-123456',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Card(
                color: Color(0xFFFFF8E1),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Veuillez inclure le numéro de commande dans votre référence de virement.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _processPayment,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.brown[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Valider le paiement',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

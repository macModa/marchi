import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/register_request.dart';
import '../providers/auth_providers.dart';
import '../../../../core/constants/app_constants.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _villeController = TextEditingController();
  final _nomBoutiqueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _adresseLivraisonController = TextEditingController();
  
  String _selectedRole = AppConstants.roleClient;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nomController.dispose();
    _telephoneController.dispose();
    _villeController.dispose();
    _nomBoutiqueController.dispose();
    _descriptionController.dispose();
    _adresseLivraisonController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final request = RegisterRequest(
        nom: _nomController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        telephone: _telephoneController.text.trim(),
        ville: _villeController.text.trim(),
        role: _selectedRole,
        nomBoutique: _selectedRole == AppConstants.roleArtisan ? _nomBoutiqueController.text.trim() : null,
        description: _selectedRole == AppConstants.roleArtisan ? _descriptionController.text.trim() : null,
        adresseLivraison: _selectedRole == AppConstants.roleClient ? _adresseLivraisonController.text.trim() : null,
      );
      
      await ref.read(authStateProvider.notifier).register(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    ref.listen(authStateProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.brown[900],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Rejoignez notre communauté',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                ),
                const SizedBox(height: 24),
                
                // Role Selection
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: AppConstants.roleClient,
                      label: Text('Client'),
                      icon: Icon(Icons.person_outline),
                    ),
                    ButtonSegment(
                      value: AppConstants.roleArtisan,
                      label: Text('Artisan'),
                      icon: Icon(Icons.storefront_outlined),
                    ),
                  ],
                  selected: {_selectedRole},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _selectedRole = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom complet',
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer votre nom';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer votre email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Email invalide';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer un mot de passe';
                    if (value.length < AppConstants.minPasswordLength) return 'Trop court';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _telephoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Téléphone',
                          prefixIcon: const Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _villeController,
                        decoration: InputDecoration(
                          labelText: 'Ville',
                          prefixIcon: const Icon(Icons.location_city_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Conditional Fields for Artisan
                if (_selectedRole == AppConstants.roleArtisan) ...[
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Informations Boutique',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nomBoutiqueController,
                    decoration: InputDecoration(
                      labelText: 'Nom de la Boutique',
                      prefixIcon: const Icon(Icons.store_mall_directory_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                    ),
                    validator: (value) {
                      if (_selectedRole == AppConstants.roleArtisan && (value == null || value.isEmpty)) {
                        return 'Le nom de la boutique est requis';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description de la Boutique',
                      prefixIcon: const Icon(Icons.description_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                    ),
                  ),
                ],

                // Conditional Fields for Client
                if (_selectedRole == AppConstants.roleClient) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _adresseLivraisonController,
                    decoration: InputDecoration(
                      labelText: 'Adresse de livraison',
                      prefixIcon: const Icon(Icons.home_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 32),
                FilledButton(
                  onPressed: authState is AsyncLoading ? null : _handleRegister,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                    backgroundColor: Colors.brown[700],
                  ),
                  child: authState is AsyncLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'S\'inscrire',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

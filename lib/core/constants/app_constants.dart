class AppConstants {
  // App Info
  static const String appName = "m'artChez";
  static const String appVersion = '1.0.0';
  
  // Design System - Colors
  static const int colorBackground = 0xFFF5EEE6; // Beige crème
  static const int colorPrimary = 0xFFB05B48;    // Terre cuite / Brique
  static const int colorSecondary = 0xFF8C9464;  // Vert olive
  static const int colorTextPrimary = 0xFF3C2F2F;   // Marron foncé
  static const int colorTextSecondary = 0xFF706565; // Marron moyen
  
  // UI Layout
  static const double defaultPadding = 20.0;
  static const double smallPadding = 10.0;
  static const double largePadding = 30.0;
  static const double borderRadius = 16.0;
  
  // Cart
  static const int maxCartQuantity = 99;
  static const int minCartQuantity = 1;
  
  // Images
  static const String placeholderImage = 'https://via.placeholder.com/400x400.png?text=Product';
  static const int maxImageSizeMB = 5;
  
  // Error Messages
  static const String errorGeneric = 'Une erreur est survenue. Veuillez réessayer.';
  static const String errorNetwork = 'Erreur de connexion. Vérifiez votre connexion internet.';
  static const String errorAuth = 'Session expirée. Veuillez vous reconnecter.';
  static const String errorNotFound = 'Ressource introuvable.';
  static const String errorValidation = 'Données invalides. Veuillez vérifier vos informations.';
  
  // Success Messages
  static const String successLogin = 'Connexion réussie !';
  static const String successRegister = 'Inscription réussie !';
  static const String successProductCreated = 'Produit créé avec succès !';
  static const String successProductUpdated = 'Produit mis à jour avec succès !';
  static const String successProductDeleted = 'Produit supprimé avec succès !';
  static const String successOrderCreated = 'Commande créée avec succès !';
  static const String successOrderCancelled = 'Commande annulée avec succès !';
  static const String successPaymentCreated = 'Paiement effectué avec succès !';

  // 🔑 Secure Storage Keys
  static const String keyAuthToken = "auth_token";
  static const String keyUserId = "user_id";
  static const String keyUserEmail = "user_email";
  static const String keyUserRole = "user_role";
  static const String keyUserName = "user_name";

  // 🔒 Password / validation
  static const int minPasswordLength = 8;

  // 👤 Roles
  static const String roleClient = "CLIENT";
  static const String roleArtisan = "ARTISAN";
  static const String roleAdmin = "ADMIN";
}

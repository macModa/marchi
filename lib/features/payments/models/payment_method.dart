enum PaymentMethod {
  carte_bancaire('CARTE_BANCAIRE'),
  virement('VIREMENT'),
  espece('ESPECE');

  final String value;
  const PaymentMethod(this.value);

  static PaymentMethod fromString(String method) {
    switch (method.toUpperCase()) {
      case 'CARTE_BANCAIRE':
        return PaymentMethod.carte_bancaire;
      case 'VIREMENT':
        return PaymentMethod.virement;
      case 'ESPECE':
        return PaymentMethod.espece;
      default:
        throw ArgumentError('Invalid payment method: $method');
    }
  }

  String toJson() => value;
}

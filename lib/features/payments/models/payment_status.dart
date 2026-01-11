enum PaymentStatus {
  en_attente('EN_ATTENTE'),
  complete('COMPLETE'),
  echoue('ECHOUE'),
  rembourse('REMBOURSE');

  final String value;
  const PaymentStatus(this.value);

  static PaymentStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'EN_ATTENTE':
        return PaymentStatus.en_attente;
      case 'COMPLETE':
        return PaymentStatus.complete;
      case 'ECHOUE':
        return PaymentStatus.echoue;
      case 'REMBOURSE':
        return PaymentStatus.rembourse;
      default:
        throw ArgumentError('Invalid payment status: $status');
    }
  }

  String toJson() => value;
}

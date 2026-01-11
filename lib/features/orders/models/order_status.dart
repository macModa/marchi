enum OrderStatus {
  en_attente('EN_ATTENTE'),
  confirmee('CONFIRMEE'),
  en_cours('EN_COURS'),
  expediee('EXPEDIEE'),
  livree('LIVREE'),
  annulee('ANNULEE');

  final String value;
  const OrderStatus(this.value);

  static OrderStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'EN_ATTENTE':
        return OrderStatus.en_attente;
      case 'CONFIRMEE':
        return OrderStatus.confirmee;
      case 'EN_COURS':
        return OrderStatus.en_cours;
      case 'EXPEDIEE':
        return OrderStatus.expediee;
      case 'LIVREE':
        return OrderStatus.livree;
      case 'ANNULEE':
        return OrderStatus.annulee;
      default:
        throw ArgumentError('Invalid order status: $status');
    }
  }

  String toJson() => value;
}

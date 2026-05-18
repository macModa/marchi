/// Payment method enum synchronized with Spring Boot backend
enum PaymentMethod {
  card,
  mobileMoney,
  bankTransfer,
  cash,
}

/// 🔄 Mapper: Backend String → Flutter Enum
/// Converts backend UPPERCASE values to Flutter enum
PaymentMethod paymentMethodFromString(String value) {
  switch (value.toUpperCase()) {
    case 'CARD':
    case 'CARTE_BANCAIRE': // Legacy support
      return PaymentMethod.card;
    case 'MOBILE_MONEY':
      return PaymentMethod.mobileMoney;
    case 'BANK_TRANSFER':
    case 'VIREMENT': // Legacy support
      return PaymentMethod.bankTransfer;
    case 'CASH':
    case 'ESPECE': // Legacy support
      return PaymentMethod.cash;
    default:
      // Fallback to cash instead of throwing to prevent crashes
      return PaymentMethod.cash;
  }
}

/// 🔄 Mapper: Flutter Enum → Backend String
/// Converts Flutter enum to backend UPPERCASE values
String paymentMethodToString(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return 'CARD';
    case PaymentMethod.mobileMoney:
      return 'MOBILE_MONEY';
    case PaymentMethod.bankTransfer:
      return 'BANK_TRANSFER';
    case PaymentMethod.cash:
      return 'CASH'; // ⚠️ NOT "ESPECE"
  }
}

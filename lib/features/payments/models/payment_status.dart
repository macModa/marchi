/// Payment status enum with clean English names
enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

/// 🔄 Mapper: Backend String → Flutter Enum
PaymentStatus paymentStatusFromString(String value) {
  switch (value.toUpperCase()) {
    case 'EN_ATTENTE':
    case 'PENDING':
      return PaymentStatus.pending;
    case 'COMPLETE':
    case 'COMPLETED':
      return PaymentStatus.completed;
    case 'ECHOUE':
    case 'FAILED':
      return PaymentStatus.failed;
    case 'REMBOURSE':
    case 'REFUNDED':
      return PaymentStatus.refunded;
    default:
      return PaymentStatus.pending;
  }
}

/// 🔄 Mapper: Flutter Enum → Backend String
String paymentStatusToString(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.pending:
      return 'EN_ATTENTE';
    case PaymentStatus.completed:
      return 'COMPLETE';
    case PaymentStatus.failed:
      return 'ECHOUE';
    case PaymentStatus.refunded:
      return 'REMBOURSE';
  }
}

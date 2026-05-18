/// Order status enum — aligned with Java backend OrderStatus enum
/// Java values: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED
enum OrderStatus {
  pending,
  confirmed,
  processing,  // ← PROCESSING (pas inProgress)
  shipped,
  delivered,
  cancelled,   // ← double L (pas canceled)
}

/// 🔄 Mapper: Backend String → Flutter Enum
OrderStatus orderStatusFromString(String? value) {
  if (value == null) return OrderStatus.pending;
  switch (value.toUpperCase().trim()) {
    case 'PENDING':
      return OrderStatus.pending;
    case 'CONFIRMED':
      return OrderStatus.confirmed;
    case 'PROCESSING':
      return OrderStatus.processing;
    case 'SHIPPED':
      return OrderStatus.shipped;
    case 'DELIVERED':
      return OrderStatus.delivered;
    case 'CANCELLED':
      return OrderStatus.cancelled;
    default:
      assert(false, '⚠️ Unknown OrderStatus from backend: "$value"');
      return OrderStatus.pending;
  }
}

/// 🔄 Mapper: Flutter Enum → Backend String
/// Sends exact Java enum values
String orderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'PENDING';
    case OrderStatus.confirmed:
      return 'CONFIRMED';
    case OrderStatus.processing:
      return 'PROCESSING';
    case OrderStatus.shipped:
      return 'SHIPPED';
    case OrderStatus.delivered:
      return 'DELIVERED';
    case OrderStatus.cancelled:
      return 'CANCELLED';
  }
}

import 'package:json_annotation/json_annotation.dart';

enum PaymentMethod {
  @JsonValue('CASH')
  cash('CASH'),
  @JsonValue('CARD')
  card('CARD'),
  @JsonValue('MOBILE_MONEY')
  mobileMoney('MOBILE_MONEY'),
  @JsonValue('BANK_TRANSFER')
  bankTransfer('BANK_TRANSFER');

  final String value;
  const PaymentMethod(this.value);

  static PaymentMethod fromString(String method) {
    switch (method.toUpperCase()) {
      case 'CASH':
      case 'ESPECE':
        return PaymentMethod.cash;
      case 'CARD':
      case 'CARTE_BANCAIRE':
        return PaymentMethod.card;
      case 'MOBILE_MONEY':
        return PaymentMethod.mobileMoney;
      case 'BANK_TRANSFER':
      case 'VIREMENT':
        return PaymentMethod.bankTransfer;
      default:
        throw ArgumentError('Invalid payment method: $method');
    }
  }

  String toJson() => value;
}

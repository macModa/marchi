import '../../features/products/models/product_dto.dart';

class CartItem {
  final ProductDto product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get subtotal => product.prix * quantity;

  CartItem copyWith({
    ProductDto? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}


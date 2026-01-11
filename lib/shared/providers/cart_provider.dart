import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../../features/products/models/product_dto.dart';

class CartState {
  final List<CartItem> items;

  CartState({this.items = const []});

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  double get total => items.fold(0.0, (sum, item) => sum + item.subtotal);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => items.isEmpty;
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  void addItem(ProductDto product, {int quantity = 1}) {
    final existingIndex = state.items.indexWhere(
      (cartItem) => cartItem.product.id == product.id,
    );

    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + quantity,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [
        ...state.items,
        CartItem(product: product, quantity: quantity)
      ]);
    }
  }

  void addToCart(CartItem item) {
    addItem(item.product, quantity: item.quantity);
  }

  void removeFromCart(int productId) {
    state = state.copyWith(
      items: state.items.where((item) => item.product.id != productId).toList(),
    );
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void clearCart() {
    state = CartState();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

